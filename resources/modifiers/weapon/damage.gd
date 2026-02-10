class_name DamageModifier
extends Modifier

@export var damage: float = 10.0

func apply(player: Player) -> void:
	player.weapons.bullet_damage = damage
