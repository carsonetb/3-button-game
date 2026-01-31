class_name PlayerInput
extends Node

signal pause_pressed

const PAUSE_TOLERANCE = 0.2 ## seconds

var accelerating: bool = false 
var turning: bool = false
var shooting: bool = false

var w_timer: Timer 
var d_timer: Timer 
var space_timer: Timer

func _ready() -> void:
	w_timer = Timer.new()
	d_timer = Timer.new()
	space_timer = Timer.new()
	add_child(w_timer)
	add_child(d_timer)
	add_child(space_timer)

func _process(_delta: float) -> void:
	accelerating = Input.is_action_pressed(&"accelerate")
	turning = Input.is_action_pressed(&"turn")
	shooting = Input.is_action_pressed(&"shoot")
	
	var input_just_pressed := false 
	if Input.is_action_just_pressed(&"accelerate"):
		w_timer.start(PAUSE_TOLERANCE)
		input_just_pressed = true
	if Input.is_action_just_pressed(&"turn"):
		d_timer.start(PAUSE_TOLERANCE)
		input_just_pressed = true 
	if Input.is_action_just_pressed(&"shoot"):
		space_timer.start(PAUSE_TOLERANCE)
		input_just_pressed = true 
	
	if input_just_pressed && !(w_timer.is_stopped() || d_timer.is_stopped() || space_timer.is_stopped()):
		print("(PlayerInput) Pause pressed")
		pause_pressed.emit()
