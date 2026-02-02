@abstract
class_name Modifier 
extends Resource

enum Type {
	SHIELD,
	WEAPON,
	ABILITY,
	HEALTH,
}
@export var type: Type

@abstract
func apply(player: Player) -> void
