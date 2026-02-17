class_name BossEvent 
extends Event 

func apply(level: Level) -> void:
	var boss_scene := preload("res://objects/boss/boss.tscn")
	var boss: Boss = boss_scene.instantiate()
	boss.position = Vector2(1000.0, 500.0)
	level.add_child(boss)
	
	await boss.destroyed
	
	level.ui.display_popup("You Win!")
