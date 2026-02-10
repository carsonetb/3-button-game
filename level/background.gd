@tool
class_name LevelBackground
extends Node2D

@export var num_stars: int = 32:
	set(val):
		num_stars = val
		queue_redraw()
@export var min_size: float = 1.0:
	set(val):
		min_size = val 
		queue_redraw()
@export var max_size: float = 5.0:
	set(val):
		max_size = val 
		queue_redraw()

func _draw() -> void:
	var size := get_viewport_rect().size
	for i in range(num_stars):
		draw_circle(Vector2(randf_range(0.0, size.x), randf_range(0.0, size.y)), randf_range(min_size, max_size), Color.WHITE)
	
