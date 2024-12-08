extends Resource
class_name Ability

@export var abilityName: String
@export var abilityCost: int

func onEnergyMet(user: HeroScene):
	#abilityEffect.cast()
	pass
