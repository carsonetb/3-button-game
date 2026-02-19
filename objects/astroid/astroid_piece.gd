class_name AstroidPiece
extends Polygon2D

var velocity: Vector2 
var rot_vel: float

func _process(delta: float) -> void:
	position += velocity * delta
	velocity *= 0.995
	scale *= 0.995
	rotation += 1.0 * delta
	
	if scale.length() < 0.01:
		queue_free()

static func create(points: PackedVector2Array, velocity: Vector2) -> AstroidPiece:
	var packed: PackedScene = load("res://objects/astroid/astroid_piece.tscn")
	var out: AstroidPiece = packed.instantiate()
	out.polygon = points 
	out.velocity = velocity
	return out
