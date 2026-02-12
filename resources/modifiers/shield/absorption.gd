class_name AbsorptionModifier
extends Modifier

@export var absorption: int = 1

func apply(player: Player) -> void:
	player.shields.absorption = absorption
