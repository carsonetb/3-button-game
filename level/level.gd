class_name Level 
extends Node2D 

@onready var bounds: Control = $BoundingBox
@onready var spawn_bounds: Control = $SpawnBox
@onready var astroid_spawn: Line2D = $AstroidSpawn

var player: Player

func _ready() -> void:
	bounds.visible = false 
	spawn_bounds.visible = false 
	
	player = Player.create()
	add_child(player)
	player.position = Util.pick_control_point(spawn_bounds)

func _on_astroid_timer_timeout() -> void:
	var segment: int = randi_range(0, astroid_spawn.points.size() - 1)
	var point1: Vector2 = astroid_spawn.points[segment]
	var point2: Vector2 = astroid_spawn.points[segment - 1]
	var pos: Vector2 = lerp(point1, point2, randf_range(0.0, 1.0))
	var intersects: Vector2 = Util.pick_control_point(spawn_bounds)
	var direction: Vector2 = pos.direction_to(intersects)
	var speed: float = randf_range(Constants.ASTROID_MIN_SPEED, Constants.ASTROID_MAX_SPEED)
	var astroid: Astroid = Astroid.create(direction, speed)
	add_child(astroid)
	astroid.position = pos 
