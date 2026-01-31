class_name Bullet 
extends Area2D

var direction: Vector2 = Vector2.ZERO 
var speed: float = 0.0

static func create(direction: Vector2, speed: float) -> Bullet:
	var packed: PackedScene = load("uid://db07di0sgxahh")
	var scene: Bullet = packed.instantiate()
	scene.direction = direction
	scene.speed = speed 
	return scene

func _process(delta: float) -> void:
	rotation = direction.angle() + deg_to_rad(90.0)
	position += direction * speed * delta
