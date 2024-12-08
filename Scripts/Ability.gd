extends Resource
class_name Ability

@export var abilityName: String
@export var abilityEffect: Script
@export var abilityCost: int

func onEnergyMet():
	#abilityEffect.cast()
	print("This is where my cast function call would go")
