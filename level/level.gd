class_name Level 
extends Node2D 

@onready var ui: IngameUI = $UI
@onready var bounds: Control = $BoundingBox
@onready var spawn_bounds: Control = $SpawnBox
@onready var astroid_spawn: Line2D = $AstroidSpawn

var player: Player
var pause_tween: Tween

func _ready() -> void:
	bounds.visible = false 
	spawn_bounds.visible = false 
	
	player = Player.create()
	add_child(player)
	player.position = Util.pick_control_point(spawn_bounds)
	player.input.pause_pressed.connect(_on_ui_pause)
	
	await player.health.died
	ui.display_death()
	await ui.restart
	get_tree().reload_current_scene()

func pause() -> void:
	ui.display_pause()
	get_tree().paused = true

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

func _on_ui_exit() -> void:
	get_tree().paused = false 
	get_tree().change_scene_to_packed(Scenes.main_menu)

func _on_ui_resume() -> void:
	get_tree().paused = false

func _on_ui_pause() -> void:
	pause()

func _on_ui_request_upgrades() -> void:
	ui.set_upgrades(player.upgrades.available.values(), player.upgrades.money)

func _on_ui_upgrade_selected(upgrade_name: String) -> void:
	player.upgrades.upgrade(upgrade_name)
	_on_ui_request_upgrades()
