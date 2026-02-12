@tool
class_name Upgrade
extends Resource 

@export var name: String
@export var modifier: Modifier
@export var cost: int:
	set(val):
		cost = val 
		_init()
@export var unlocks: Array[String]:
	set(val):
		unlocks = val 
		_init()

var key_name: String

func _init() -> void:
	call_deferred("set", "resource_name", "${0} -> {1}".format([cost, str(unlocks)]))

func _to_string() -> String:
	return "Name: {0} | Cost: {1}".format([name, cost])
