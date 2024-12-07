extends Node2D
class_name HeroScene

@export var heroData: Hero

var hp:int
var damage:int
var attackCooldown:float
var preferredTarget:int
var critChance:int

@export var ability:Ability
@export var passive:Passive

func _ready() -> void:
	hp = heroData.hp
	damage = heroData.damage
	attackCooldown = heroData.attackCooldown
	preferredTarget = heroData.preferredTarget
	critChance = heroData.critChance

func attack():
	#Tell battlemanager to attack a target 
	get_parent().dealAttack(self, preferredTarget, damage)
	#print("I am attacking!")
	
