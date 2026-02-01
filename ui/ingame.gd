class_name IngameUI
extends CanvasLayer

signal exit 
signal restart 
signal resume

@onready var pause_menu: Control = $Pause
@onready var death_menu: Control = $Death

func _ready() -> void:
	pause_menu.visible = false 
	death_menu.visible = false

func display_death() -> void:
	pause_menu.visible = false
	death_menu.visible = true

func display_pause() -> void:
	death_menu.visible = false
	pause_menu.visible = true 

func _on_exit_pressed() -> void:
	exit.emit()

func _on_restart_pressed() -> void:
	restart.emit()

func _on_resume_pressed() -> void:
	resume.emit()
