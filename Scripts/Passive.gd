extends Resource
class_name Passive

@export var passiveName: String
@export var passiveDescription: String

func _init() -> void:
	resource_local_to_scene = true

func setup(hero: HeroScene):
	pass
