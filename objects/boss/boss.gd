class_name Boss
extends Area2D

signal destroyed

@onready var level: Level = get_parent()
@onready var health: AstroidHealth = $Health
@onready var bullet_scene := preload("res://objects/boss/bullet.tscn")
@onready var poly: Polygon2D = $Poly

var even: bool = true

func _ready() -> void:
	var spawn_tween := get_tree().create_tween()
	scale = Vector2.ZERO
	spawn_tween.tween_property(self, ^"scale", Vector2(1.0, 1.0), 5.0)
	
	await health.died 
	
	destroyed.emit()
	
	var step: int = [2, 4, 8, 16].pick_random()
	var total := Vector2.ZERO
	for point in poly.polygon:
		total += point 
	var avg := total / float(poly.polygon.size())
	for i in range(0, poly.polygon.size(), step):
		var slice_points: Array[Vector2] = []
		for j in range(step):
			slice_points.append(poly.polygon[i + j])
		slice_points.append(avg)
		var chunk := AstroidPiece.create(slice_points, Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * 250.0)
		get_parent().add_child(chunk)
		chunk.scale = scale
		chunk.global_position = global_position
	
	for i in range(int(10000) / 5):
		var money := Money.create(level.player)
		level.add_child(money)
		money.global_position = global_position + Vector2(randf_range(-150.0, 150.0), randf_range(-150.0, 150.0))
	
	queue_free()

func _process(delta: float) -> void:
	position += global_position.direction_to(level.player.global_position) * delta * 60.0 
	rotation += 0.35 * delta

func _on_area_entered(area: Area2D) -> void:
	if !area is Bullet:
		return
	var as_bullet := area as Bullet
	health.damage(as_bullet.damage)
	area.queue_free()

func _on_shoot_timeout() -> void:
	var bullet: BossBullet = bullet_scene.instantiate()
	bullet.velocity = ((1.0 if even else -1.0) * Vector2.from_angle(rotation)) * 170.0
	even = !even 
	level.add_child(bullet)
	bullet.global_position = $LeftSpawn.global_position if even else $RightSpawn.global_position
