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
	
	if pause_button.process(delta, [Input.is_action_just_pressed(&"left"), Input.is_action_just_pressed(&"right"), Input.is_action_just_pressed(&"accelerate")]):
		pause_pressed.emit()
	
	if shoot_toggle.process(delta, [Input.is_action_just_pressed(&"left"), Input.is_action_just_pressed(&"right")]):
		shooting = !shooting
