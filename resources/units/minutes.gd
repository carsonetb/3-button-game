@tool
class_name Minutes
extends TimeUnit

@export var value: float:
	set(val):
		value = val 
		resource_name = _to_string()

func in_seconds() -> float:
	return value * 60.0

func in_minutes() -> float:
	return value

func _to_string() -> String:
	return "{0} minute{1}".format([int(round(value)), "" if value == 1.0 else "s"])
