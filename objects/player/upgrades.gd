class_name PlayerUpgrades
extends Node

@export var start_money: int

var available: Dictionary[String, Upgrade] = {}
var money: int = start_money

func upgrade(upgrade_name: String) -> void:
	# TODO: This will update the available upgrades based on a tree structure
	pass
