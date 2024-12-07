extends Node2D
class_name HeroScene

@export var heroData: Hero

#References to children
@onready var healthBar: ProgressBar = $Healthbar

var hp:int : set = updateHealthbar #this set line makes it so that whenever hp
# is changed updateHealthbar is ran
var damage:int
var attackCooldown:float
var preferredTarget:int
var critChance:int

@export var ability:Ability
@export var passive:Passive

var tween: Tween

func _ready() -> void:
	hp = heroData.hp
	damage = heroData.damage
	attackCooldown = heroData.attackCooldown
	preferredTarget = heroData.preferredTarget
	critChance = heroData.critChance
	
	#Run this at the end of ready to make sure healthBar has access to the right values
	healthBar.initializeValues()


func attack():
	#Tell battlemanager to attack a target
	get_parent().dealAttack(self, preferredTarget, damage)
	#print("I am attacking!")

func updateHealthbar(newHp: int):
	healthBar.update(newHp)
	hp = newHp
	print(name + "'s hp is now" + str(hp))

func takedamage():
	hp -= 10
