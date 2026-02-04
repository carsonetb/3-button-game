class_name MainMenu
extends Node2D

var logger := DebugLogger.new("MainMenu")

@onready var start_button: Button = $Start

func _ready() -> void:
	start_button.grab_focus()
	logger.initialize()

func _on_start_pressed() -> void:
	logger.info("Start game.")
	get_tree().change_scene_to_packed(Scenes.level)

func _on_exit_pressed() -> void:
	logger.info("Exit game. Bye!")
	get_tree().quit()
