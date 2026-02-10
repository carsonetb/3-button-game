extends Node

@export var start_upgrades: Array[String]
@export var upgrades: Dictionary[String, Upgrade]

func _ready() -> void:
	for key: String in upgrades.keys():
		upgrades[key].key_name = key
