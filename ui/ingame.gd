class_name IngameUI
extends CanvasLayer

signal exit 
signal restart 
signal resume
signal request_upgrades
signal upgrade_selected(upgrade_name: String)

@onready var pause_menu: Control = $Pause
@onready var death_menu: Control = $Death
@onready var upgrades_menu: Control = $Upgrades

@onready var restart_button: Button = $Death/Restart
@onready var resume_button: Button = $Pause/Resume
@onready var back_button: Button = $Upgrades/Back
@onready var upgrades_container: VBoxContainer = $Upgrades/Container

func _ready() -> void:
	hide_menus()

func set_upgrades(upgrades: Array[Upgrade], money: int) -> void:
	for child in upgrades_container.get_children():
		upgrades_container.remove_child(child)
		child.queue_free()
	
	for upgrade: Upgrade in upgrades:
		var button: Button = Button.new()
		button.text = str(upgrade)
		button.disabled = money < upgrade.cost
		button.pressed.connect(_on_upgrade_pressed.bind(upgrade.name))
		upgrades_container.add_child(button)
	
	var children := upgrades_container.get_children()
	for i in range(children.size()):
		var button: Button = children[i]
		if i == 0:
			button.focus_neighbor_top = button.get_path_to(back_button)
		else:
			button.focus_neighbor_top = button.get_path_to(children[i - 1])
		if i == children.size() - 1:
			button.focus_neighbor_bottom = button.get_path_to(back_button)
		else:
			button.focus_neighbor_bottom = button.get_path_to(children[i + 1])
	
	if children.size() == 0:
		back_button.focus_neighbor_top = ^"."
		back_button.focus_neighbor_bottom = ^"."
	else:
		back_button.focus_neighbor_top = back_button.get_path_to(children[children.size() - 1])
		back_button.focus_neighbor_bottom = back_button.get_path_to(children[0])

func display_death() -> void:
	hide_menus()
	death_menu.visible = true
	restart_button.grab_focus()

func display_pause() -> void:
	hide_menus()
	pause_menu.visible = true
	resume_button.grab_focus()

func display_upgrades() -> void:
	hide_menus()
	upgrades_menu.visible = true 
	back_button.grab_focus()

func hide_menus() -> void:
	death_menu.visible = false 
	pause_menu.visible = false
	upgrades_menu.visible = false

func _on_upgrade_pressed(upgrade_name: String) -> void:
	upgrade_selected.emit(upgrade_name)
	back_button.grab_focus()

func _on_exit_pressed() -> void:
	exit.emit()

func _on_restart_pressed() -> void:
	restart.emit()

func _on_resume_pressed() -> void:
	hide_menus()
	resume.emit()

func _on_back_pressed() -> void:
	display_pause()

func _on_upgrades_pressed() -> void:
	request_upgrades.emit()
	display_upgrades()
