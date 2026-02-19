class_name Money 
extends Node2D

var player: Player 
var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	velocity += global_position.direction_to(player.global_position) * delta * 1000.0
	velocity *= 0.99
	position += velocity * delta
	
	if global_position.distance_to(player.global_position) < 10.0:
		player.upgrades.money += 1
		queue_free()

static func create(player: Player) -> Money:
	var scene: PackedScene = load("res://objects/player/money/money.tscn")
	var out: Money = scene.instantiate()
	out.player = player 
	out.velocity = Vector2(randf_range(-100.0, 100.0), randf_range(-100.0, 100.0))
	return out
