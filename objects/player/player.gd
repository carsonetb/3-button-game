class_name Player
extends Area2D

const ACCEL: float = 100.0 ## px/s/s
const FRIC: float = 0.1
const RACCEL: float = 600.0 ## deg/s/s
const RFRIC: float = 600.0 ## deg/s/s

var velocity := Vector2.ZERO
var rot_vel := 0.0

var direction: Vector2:
	get:
		return Vector2.from_angle(rotation)
	set(val):
		rotation = val.angle()

@onready var input: PlayerInput = $Input
@onready var weapons: PlayerWeapons = $Weapons

func _process(delta: float) -> void:
	if input.accelerating:
		velocity += direction * ACCEL * delta
	else:
		velocity *= FRIC * delta
	
	if input.turning:
		rot_vel += deg_to_rad(RACCEL) * delta
	elif rot_vel > 0.0:
		rot_vel -= deg_to_rad(RFRIC) * delta 
	else:
		rot_vel = 0.0
	
	position += velocity * delta
	rotation += rot_vel * delta
