class_name Player
extends Area2D

var velocity := Vector2.ZERO
var rot_vel := 0.0

var direction: Vector2:
	get:
		return Vector2.from_angle(rotation)
	set(val):
		rotation = val.angle()

var movement_direction: Vector2:
	get:
		return velocity.normalized()

@onready var input: PlayerInput = $Input
@onready var weapons: PlayerWeapons = $Weapons
@onready var hud: PlayerHUD = $HUD

func _process(delta: float) -> void:
	if input.accelerating:
		velocity += input.accel_force * direction * Constants.PLAYER_ACCEL * delta
	else:
		velocity = lerp(velocity, Vector2.ZERO, Constants.PLAYER_FRIC)
	
	if input.turning:
		rot_vel += input.turn_force * deg_to_rad(Constants.PLAYER_RACCEL) * delta
	else:
		rot_vel = lerp(rot_vel, 0.0, Constants.PLAYER_RFRIC)
	
	if velocity.length() > Constants.PLAYER_MAX_SPEED:
		velocity = movement_direction * Constants.PLAYER_MAX_SPEED
	if abs(rot_vel) > deg_to_rad(Constants.PLAYER_RMAX_SPEED):
		rot_vel = sign(rot_vel) * deg_to_rad(Constants.PLAYER_RMAX_SPEED)
	
	position += velocity * delta
	rotation += rot_vel * delta

static func create(direction: Vector2 = Vector2.ZERO) -> Player:
	var packed: PackedScene = load("uid://bh6uqjn50sxf2")
	var node: Player = packed.instantiate()
	node.direction = direction 
	return node
