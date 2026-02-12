class_name RechargeModifier
extends Modifier

@export var recharge_time: float = 10.0

func apply(player: Player) -> void:
	player.shields.recharge_time = recharge_time
