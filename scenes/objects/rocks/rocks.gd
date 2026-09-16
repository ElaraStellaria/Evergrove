extends Node2D

@onready var hurt_component: HurtComponent = $rocks/HurtComponent
@onready var damage_component: DamageComponent = $rocks/DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.mix_damage_reached.connect(mix_damage_reached)
	
func on_hurt(hit_damage: int) -> void:
	damage_component.apple_damage(hit_damage)

	material.set_shader_parameter("shake_intensity", 0.3)
	material.set_shader_parameter("shake_speed", 20.0)

	await get_tree().create_timer(0.5).timeout

	material.set_shader_parameter("shake_intensity", 0.0)


	
func mix_damage_reached() -> void:
	call_deferred("add_stone_scene")
	queue_free()

func add_stone_scene() -> void:
	var stone_instanca = stone_scene.instantiate() as Node2D
	stone_instanca.global_position = global_position
	get_parent().add_child(stone_instanca)
