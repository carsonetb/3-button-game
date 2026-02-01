class_name MultiButton

var _num_buttons: int = 0
var _button_timers: Array[float]
var threshold: float = 0.2

func _init(num: int, thresh: float = 0.2) -> void:
	_num_buttons = num 
	_button_timers.resize(num)
	threshold = thresh

func process(delta: float, pressed: Array[bool]) -> bool:
	assert(pressed.size() == _button_timers.size())
	
	for i in range(_button_timers.size()):
		_button_timers[i] -= delta
		if _button_timers[i] < 0.0:
			_button_timers[i] = 0.0
	
	var any_pressed: bool = false
	for i in range(pressed.size()):
		if !pressed[i]:
			continue 
		any_pressed = true 
		_button_timers[i] = threshold
	
	if !any_pressed:
		return false
	
	var any_finished: bool = false
	for timer in _button_timers:
		if timer <= 0.0:
			any_finished = true 
			break 
	
	if any_finished:
		return false
	
	return true
