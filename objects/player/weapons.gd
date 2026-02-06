class_name PlayerWeapons 
extends Node2D 

@onready var player: Player = get_parent()
@onready var shoot_timer: Timer = $Shoot
@onready var bullet_scene: PackedScene = preload("uid://db07di0sgxahh") # objects/bullet/bullet.tscn

var bullet_speed: float = 1000.0 # px/s

func _process(delta: float) -> void:
	if !player.input.shooting || !shoot_timer.is_stopped():
		return
	
	shoot_timer.start()
	var bullet := Bullet.create(player.direction, bullet_speed)
	player.get_parent().add_child(bullet) # TODO: Make this access world or something.
	bullet.global_position = player.global_position
	
