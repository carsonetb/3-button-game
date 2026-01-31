class_name Astroid 
extends Area2D 

const MIN_SCALE: float = 0.2
const MAX_SCALE: float = 2.0
const MAX_ROT_VEL: float = 90.0 ## deg/s

var velocity: Vector2 = Vector2.ZERO 
var rot_vel: float = 0.0

@onready var health: AstroidHealth = $Health

func _ready() -> void:
	scale *= randf_range(MIN_SCALE, MAX_SCALE)
	rotation = randf_range(0.0, TAU)
	rot_vel = randf_range(0.0, deg_to_rad(MAX_ROT_VEL))
	
	await health.died 
	
	queue_free()

func _process(delta: float) -> void:
	position += velocity * delta
	rotation += rot_vel * delta

static func create(velocity: Vector2) -> Astroid:
	var packed: PackedScene = load("uid://xf7i50mgnjds")
	var out: Astroid = packed.instantiate()
	out.velocity = velocity 
	return out
