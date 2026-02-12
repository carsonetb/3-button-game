class_name GreenRockModifier
extends Modifier

@export var chance: float = 0.0

func apply(player: Player) -> void:
	player.level.green_rock_chance = chance
