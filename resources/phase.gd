@tool
class_name Phase
extends Resource 

@export var name: String:
	set(val):
		name = val 
		reload_name()
@export var time: TimeUnit:
	set(val):
		time = val 
		reload_name()
@export var spawn_interval: TimeUnit
@export var strong_chance: float = 0.01
@export var events: Array ## This will be built later with the "Event" type

func _init() -> void:
	reload_name.call_deferred()

func reload_name() -> void:
	resource_name = "{0}: {1}".format([name, time])
