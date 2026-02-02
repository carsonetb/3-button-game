extends Node

const start_upgrades: Array[String] = [
	"shield_first",
]

var upgrades: Dictionary[String, Upgrade] = {
	"shield_first": Upgrade.new("shield_first", 10, load("uid://dg5c7q1c0wrl3") as Modifier, ["shield_2x", "shield_10%"]),
	"shield_2x": Upgrade.new("shield_2x", 20, load("uid://bq5fv62g8j8ge") as Modifier, []),
	"shield_10%": Upgrade.new("shield_10%", 30, load("uid://ca48mb1gln3n6") as Modifier, []),
}
