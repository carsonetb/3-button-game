class_name Boss
extends Area2D

signal destroyed

@onready var level: Level = get_parent()
@onready var health: AstroidHealth = $Health
@onready var bullet_scene := preload("res://objects/boss/bullet.tscn")

var even: bool = true

func _ready() -> void:
	var spawn_tween := get_tree().create_tween()
	scale = Vector2.ZERO
	spawn_tween.tween_property(self, ^"scale", Vector2(1.0, 1.0), 5.0)
	
	await health.died 
	
	destroyed.emit()

func _process(delta: float) -> void:
	rotation += 0.2 * delta

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
