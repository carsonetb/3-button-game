class_name PlayerInput
extends Node

signal pause_pressed

const PAUSE_TOLERANCE = 0.2 ## seconds

var accel_force: float = 0.0
var accelerating: bool = false
var turn_force: float = 0.0
var turning: bool = false
var shooting: bool = false
var pause_button: MultiButton = MultiButton.new(3)
var shoot_toggle: MultiButton = MultiButton.new(2, 0.05)

func _process(delta: float) -> void:
	
	accel_force = Input.get_action_strength(&"accelerate")
	accelerating = abs(accel_force) > 0.0
	turn_force = Input.get_axis(&"left", &"right")
	turning = abs(turn_force) > 0.0
	
	var left_pressed := Input.is_action_just_pressed(&"left")
	var right_presed := Input.is_action_just_pressed(&"right")
	
	if pause_button.process(delta, [left_pressed, right_presed, Input.is_action_just_pressed(&"accelerate")]):
		pause_pressed.emit()
		left_pressed = false 
		right_presed = false
	
	if shoot_toggle.process(delta, [left_pressed, right_presed]):
		shooting = !shooting
