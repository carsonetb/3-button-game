class_name BossBullet
extends Area2D

var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	position += velocity * delta 
	rotation = velocity.angle()


func _on_timer_timeout() -> void:
	queue_free()
