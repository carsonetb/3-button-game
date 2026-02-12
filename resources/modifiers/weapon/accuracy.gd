class_name AccuracyModifier
extends Modifier

@export var variation: float = 10.0 ## degrees

func apply(player: Player) -> void:
	player.weapons.variation = variation
