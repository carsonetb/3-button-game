class_name PlayerHealth
extends Node

signal damaged(new_health: int)
signal died

@export var start_health: int = 3

var health: int = start_health
var invincible: bool = false

@onready var player: Player = get_parent()
@onready var invincibility_timer: Timer = $Invincibility

func _ready() -> void:
	await get_tree().process_frame
	player.hud.set_lives(health)

func damage() -> void:
	if !invincibility_timer.is_stopped():
		return
	health -= 1
	player.hud.set_lives(health)
	invincible = true
	invincibility_timer.start()
	damaged.emit(health)
	if health < 0:
		health = 0
		died.emit()

func _on_invincibility_timeout() -> void:
	invincible = false
