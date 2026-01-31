class_name PlayerWeapons 
extends Node2D 

const BULLET_SPEED: float = 1000.0 # px/s

@onready var player: Player = get_parent()
@onready var shoot_timer: Timer = $Shoot
@onready var bullet_scene: PackedScene = preload("uid://db07di0sgxahh") # objects/bullet/bullet.tscn

func _process(delta: float) -> void:
	if !player.input.shooting || !shoot_timer.is_stopped():
		return
	
	shoot_timer.start()
	var bullet := Bullet.create(player.direction, BULLET_SPEED)
	player.get_parent().add_child(bullet) # TODO: Make this access world or something.
	bullet.global_position = player.global_position
	
