class_name PlayerWeapons 
extends Node2D 

enum FireDirection {
	FORWARD,
	LEFT,
	RIGHT,
	REVERSE
}

var bullet_speed: float = 1000.0 # px/s
var bullet_damage: float = 10.0
var fire_rate: float = 0.1 # s
var directions: Array[FireDirection] = [FireDirection.FORWARD]
var variation: float = 10.0 # deg

@onready var player: Player = get_parent()
@onready var shoot_timer: Timer = $Shoot
@onready var bullet_scene: PackedScene = preload("uid://db07di0sgxahh") # objects/bullet/bullet.tscn

var bullet_speed: float = 1000.0 # px/s

func _process(delta: float) -> void:
	if !player.input.shooting || !shoot_timer.is_stopped():
		return
	
	shoot_timer.wait_time = fire_rate
	shoot_timer.start()
	
	for direction in directions:
		var bullet_direction: Vector2
		if direction == FireDirection.FORWARD:
			bullet_direction = player.direction
		if direction == FireDirection.LEFT:
			bullet_direction = player.direction.rotated(deg_to_rad(-20.0))
		if direction == FireDirection.RIGHT:
			bullet_direction = player.direction.rotated(deg_to_rad(20.0))
		if direction == FireDirection.REVERSE:
			bullet_direction = -player.direction
		var this_variation := deg_to_rad(randf_range(-variation, variation))
		var bullet := Bullet.create(bullet_direction.rotated(this_variation), bullet_speed)
		bullet.damage = bullet_damage
		player.get_parent().add_child(bullet) # TODO: Make this access world or something.
		bullet.global_position = player.global_position
	
