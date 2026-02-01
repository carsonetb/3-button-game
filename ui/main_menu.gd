class_name MainMenu
extends Node2D

enum MenuState { START, EXIT, TRANSITIONING }
var state := MenuState.START

@onready var selector_animator: AnimationPlayer = $SelectorAnimator
@onready var level: PackedScene = preload("uid://nj834utfqy6y")

func _process(delta: float) -> void:
	match state:
		MenuState.START:
			if Input.is_action_just_pressed(&"menu_down"):
				select_exit()
			if Input.is_action_just_pressed(&"menu_select"):
				get_tree().change_scene_to_packed(level)
		MenuState.EXIT:
			if Input.is_action_just_pressed(&"menu_up"):
				select_start()
			if Input.is_action_just_pressed(&"menu_select"):
				get_tree().quit()

func select_start() -> void:
	state = MenuState.TRANSITIONING
	selector_animator.play(&"select_start")
	await selector_animator.animation_finished
	state = MenuState.START 
	
func select_exit() -> void:
	state = MenuState.TRANSITIONING
	selector_animator.play_backwards(&"select_start")
	await selector_animator.animation_finished
	state = MenuState.EXIT 
