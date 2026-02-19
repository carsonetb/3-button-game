class_name Money 
extends Node2D

var player: Player 
var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	if !player:
		return
	velocity += global_position.direction_to(player.global_position).rotated(randf_range(-0.1, 0.1)) * delta * 1500.0
	velocity *= 0.98
	position += velocity * delta
	rotation += 3.0 * delta
	
	if global_position.distance_to(player.global_position) < 10.0:
		player.upgrades.money += 5
		queue_free()

static func create(player: Player) -> Money:
	var scene: PackedScene = load("res://objects/player/money/money.tscn")
	var out: Money = scene.instantiate()
	out.player = player 
	out.velocity = Vector2(randf_range(-100.0, 100.0), randf_range(-100.0, 100.0))
	return out
