class_name Astroid 
extends Area2D 

signal hit
signal destroyed(money: int)

var velocity: Vector2 = Vector2.ZERO 
var rot_vel: float = 0.0

@onready var health: AstroidHealth = $Health

func _ready() -> void:
	scale *= randf_range(Constants.ASTROID_MIN_SCALE, Constants.ASTROID_MAX_SCALE)
	rotation = randf_range(0.0, TAU)
	rot_vel = randf_range(0.0, deg_to_rad(Constants.ASTROID_MAX_ROT_VEL))
	var worth := (scale.length() - 0.4) * 20.0
	
	await health.died 
	
	destroyed.emit(worth)
	queue_free()

func _process(delta: float) -> void:
	position += velocity * delta
	rotation += rot_vel * delta

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
