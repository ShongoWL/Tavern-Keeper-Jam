class_name bulkUp 
extends Ability


@export var damageBoost: int
@export var critChanceBoost: int


func _ready():
	pass

#Bulk up will increas attack power and crit chance of it's user
func onEnergyMet(user: HeroScene):
	user.damage += damageBoost
	user.critChance += critChanceBoost
	print(user.charName, "'s damage increased by ", damageBoost)
	print(user.charName, "'s crit chance increased by ", critChanceBoost)
	pass
