class_name Upgrade
extends Resource 

@export var name: String
@export var cost: int
@export var modifier: Modifier
@export var unlocks: Array[String]

func _init(_name: String, _cost: int, _modifier: Modifier, _unlocks: Array[String]) -> void:
	name = _name 
	cost = _cost 
	modifier = _modifier
	unlocks = _unlocks

func _to_string() -> String:
	return "Name: {0} | Cost: {1}".format([name, cost])
