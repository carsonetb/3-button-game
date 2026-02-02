class_name Upgrade
extends Resource 

@export var name: String
@export var cost: int
@export var modifier: Modifier

func _to_string() -> String:
	return "Name: %s | Cost: %d".format([name, cost])
