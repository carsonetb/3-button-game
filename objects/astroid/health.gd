class_name AstroidHealth
extends Node2D

signal damaged(new_health: float)
signal died

@export var health: float = 100.0

@onready var health_bar: ProgressBar = $HealthBar

func _ready() -> void:
	await get_tree().process_frame
	health_bar.max_value = health

func _process(delta: float) -> void:
	health_bar.value = health
	global_rotation = 0.0

func damage(amount: float) -> void:
	health -= amount 
	damaged.emit(health)
	if health <= 0:
		health = 0.0
		died.emit()
