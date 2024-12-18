extends Entity
class_name Hero

@export var critChance: int = 0
@export var energyRegen: int = 1
@export var critModifier: int = 2

@export var ability: Ability

@export var passive: Passive

var user: HeroScene

var energyLevel: float

func setup(user: HeroScene) -> void:
	user = user
