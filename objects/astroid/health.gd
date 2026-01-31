class_name AstroidHealth
extends Node2D

signal damaged(new_health: float)
signal died

const START_HEALTH: float = 100.0

var health: float = START_HEALTH

@onready var health_bar: ProgressBar = $HealthBar

func _process(delta: float) -> void:
	health_bar.value = health
	global_rotation = 0.0

func damage(amount: float) -> void:
	health -= amount 
	damaged.emit(health)
	if health <= 0:
		health = 0.0
		died.emit()
