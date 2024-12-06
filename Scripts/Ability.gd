extends Resource
class_name Ability

@export var abilityName: String
@export var abilityEffect: Script

func onEnergyMet():
	abilityEffect.cast()
