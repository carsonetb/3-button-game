class_name FireRateModifier
extends Modifier 

@export var fire_rate: float = 0.1

func apply(player: Player) -> void:
	player.weapons.fire_rate = fire_rate
