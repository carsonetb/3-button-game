@tool
class_name PlayerHUD 
extends CanvasLayer

@export var life_icon: Texture2D
@export var lives_start: Node2D
@export var icon_separation: float = 80.0: ## pixels
	set(val):
		icon_separation = val 
		if Engine.is_editor_hint():
			set_lives(start_lives)
@export var start_lives: int = 3:
	set(val):
		start_lives = val 
		if Engine.is_editor_hint():
			set_lives(start_lives)

func set_lives(amount: int) -> void:
	for child in get_children():
		if child is Sprite2D:
			child.queue_free()
	
	for i in range(amount):
		var sprite := Sprite2D.new()
		sprite.texture = life_icon
		add_child(sprite)
		sprite.position = lives_start.position + Vector2(i * icon_separation, 0.0)
