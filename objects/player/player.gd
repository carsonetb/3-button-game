class_name Player
extends Area2D

var velocity := Vector2.ZERO
var rot_vel := 0.0
var logger := DebugLogger.new("Player")

var direction: Vector2:
	get:
		return Vector2.from_angle(rotation)
	set(val):
		rotation = val.angle()

var movement_direction: Vector2:
	get:
		return velocity.normalized()

@onready var hud: PlayerHUD = $HUD
@onready var weapons: PlayerWeapons = $Weapons
@onready var input: PlayerInput = $Input
@onready var health: PlayerHealth = $Health
@onready var upgrades: PlayerUpgrades = $Upgrades
@onready var shields: PlayerShields = $Shields

@onready var visibility_timer: Timer = $DamagedVisibility

func _ready() -> void:
	logger.initialize()
	
	await health.died
	
	queue_free()

func _process(delta: float) -> void:
	# -- Movement --
	
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
	
	# -- Animation --
	
	if !health.invincible && !visibility_timer.is_stopped():
		visibility_timer.stop()
		visible = true
	
	hud.set_money(upgrades.money)

func _on_area_entered(area: Area2D) -> void:
	health.damage()

func _on_health_damaged(new_health: int) -> void:
	visibility_timer.start()

func _on_damaged_visibility_timeout() -> void:
	visible = !visible

static func create(direction: Vector2 = Vector2.ZERO) -> Player:
	var packed: PackedScene = load("uid://bh6uqjn50sxf2")
	var node: Player = packed.instantiate()
	node.direction = direction 
	return node
