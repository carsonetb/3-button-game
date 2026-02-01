class_name MainMenu
extends Node2D

@onready var level: PackedScene = preload("uid://nj834utfqy6y")
@onready var start_button: Button = $Start

func _ready() -> void:
	start_button.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(level)

func _on_exit_pressed() -> void:
	get_tree().quit()
