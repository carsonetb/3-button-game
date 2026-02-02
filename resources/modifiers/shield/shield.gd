class_name ShieldModifier 
extends Modifier

@export var absorption: int = 1
@export var recharge_time: float = 2.0

func apply(player: Player) -> void:
	player.shields.activate(absorption, recharge_time)
