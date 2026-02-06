class_name PlayerShields
extends Node

var active: bool = false:
	set(val):
		active = val
		if !recharging:
			sprite.visible = active
var max_absorption: int = 0
var absorption: int = 0
var recharge_time: float = 0.

var recharging: bool:
	get:
		return !recharge_timer.is_stopped()

@onready var recharge_timer: Timer = $Recharge
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.visible = false

func recharge() -> void:
	while recharging:
		sprite.visible = !sprite.visible 
		await get_tree().create_timer(0.05).timeout
	sprite.visible = true

func consume(damage: int) -> int:
	if !active || absorption == 0:
		return damage 
	var out: int = max(0, damage - absorption)
	absorption = max(0, absorption - damage)
	if absorption <= 0:
		absorption = 0
		recharge_timer.start()
	recharge()
	return out

func activate(_absorption: int, _recharge_time: float) -> void:
	active = true 
	max_absorption = _absorption
	absorption = _absorption
	recharge_time = _recharge_time
	recharge_timer.wait_time = recharge_time

func _on_recharge_timeout() -> void:
	absorption = max_absorption
