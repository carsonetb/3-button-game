class_name Player
extends Area2D

const ACCEL: float = 10.0 ## px/s/s
const RACCEL: float = 10.0 ## deg/s/s
const RFRIC: float = 4.0 ## deg/s/s

var vel := Vector2.ZERO
var rvel := 0.0

@onready var input: PlayerInput = $Input

func _process(delta: float) -> void:
	var direction := Vector2.from_angle(rotation)
	
	if input.accelerating:
		vel += direction * ACCEL * delta
	
	if input.turning:
		rvel += deg_to_rad(RACCEL) * delta
	elif rvel > 0.0:
		rvel -= deg_to_rad(RFRIC) * delta 
	else:
		rvel = 0.0
	
	position += vel * delta
	rotation += rvel * delta
