class_name PlayerUpgrades
extends Node

var available: Dictionary[String, Upgrade] = {}

@onready var money: int = 100
@onready var player: Player = get_parent()

func _ready() -> void:
	for upgrade_name: String in UpgradeDB.start_upgrades:
		available[upgrade_name] = UpgradeDB.upgrades[upgrade_name]

func upgrade(upgrade_name: String) -> void:
	var upgraded: Upgrade = available[upgrade_name]
	available.erase(upgrade_name)
	
	money -= upgraded.cost
	for unlocks_name: String in upgraded.unlocks:
		available[unlocks_name] = UpgradeDB.upgrades[unlocks_name]
	upgraded.modifier.apply(player)
	
