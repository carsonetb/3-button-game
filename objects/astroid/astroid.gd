@tool
class_name Astroid 
extends Area2D 

signal hit
signal destroyed(money: int)

@export_tool_button("Regenerate") var tool_regenerate: Callable = generate_poly

@export var num_points: int = 32
@export var radius: float = 0.0
@export var noise_scale: float = 3.0

var velocity: Vector2 = Vector2.ZERO 
var rot_vel: float = 0.0

@onready var poly: Polygon2D = $Poly
@onready var health: AstroidHealth = $Health

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	scale *= randf_range(Constants.ASTROID_MIN_SCALE, Constants.ASTROID_MAX_SCALE)
	rotation = randf_range(0.0, TAU)
	rot_vel = randf_range(0.0, deg_to_rad(Constants.ASTROID_MAX_ROT_VEL))
	var worth := (scale.length() - 0.4) * 20.0
	
	await health.died 
	
	destroyed.emit(worth)
	queue_free()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	position += velocity * delta
	rotation += rot_vel * delta

func generate_poly() -> void:
	var new_polygon: Array[Vector2] = []
	for i in range(num_points):
		var angle := (float(i) / float(num_points)) * TAU
		var noise := randf_range(0.0, noise_scale)
		var pos := Vector2(cos(angle), sin(angle)) * (radius + noise)
		new_polygon.append(pos)
	poly.polygon = new_polygon

func _on_area_entered(area: Area2D) -> void:
	if !area is Bullet:
		return
	var as_bullet := area as Bullet
	health.damage(as_bullet.damage)
	area.queue_free()
	hit.emit()

static func create_ex(velocity: Vector2) -> Astroid:
	var packed: PackedScene = load("uid://xf7i50mgnjds")
	var out: Astroid = packed.instantiate()
	out.velocity = velocity 
	return out

static func create(direction: Vector2, speed: float) -> Astroid:
	return create_ex(direction * speed)
