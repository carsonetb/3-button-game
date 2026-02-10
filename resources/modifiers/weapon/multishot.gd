class_name MultishotModifier
extends Modifier

@export var shot: PlayerWeapons.FireDirection

func apply(player: Player) -> void:
	if shot in player.weapons.directions:
		Logging.warning("Modifiers", "Multishot modifier added index {0} that already existed.".format([shot]))
		return
	player.weapons.directions.append(shot)
