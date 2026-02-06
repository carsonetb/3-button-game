class_name PlayerAnimation
extends Node2D

var boost_process: ParticleProcessMaterial:
	get:
		return boost_particles.process_material
var boost_enabled: bool = false
var sprite_visible: bool = true

@onready var player: Player = get_parent()
@onready var boost_particles: GPUParticles2D = $Boost
@onready var texture: Node2D = $Texture

func _process(delta: float) -> void:
	boost_particles.emitting = boost_enabled
	var new_gravity := -player.direction * 300.0
	boost_process.gravity.x = new_gravity.x
	boost_process.gravity.y = new_gravity.y
	
	texture.visible = sprite_visible
