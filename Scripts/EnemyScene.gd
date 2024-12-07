extends Node2D
class_name EnemyScene

@export var enemyData: Entity

var damageQueue:Array = []

var hp:int 
var damage:int
var attackCooldown:float
var preferredTarget:int

var tween: Tween
var lock: bool = false

func _ready() -> void:
	hp = enemyData.hp
	damage = enemyData.damage
	attackCooldown = enemyData.damage
	preferredTarget = enemyData.preferredTarget

func _process(delta: float) -> void:
	#print("the monster's health is now ", hp)
	var tempSize = damageQueue.size()
	for action in damageQueue:
		action.call()
	for number in tempSize:
		damageQueue.pop_front()

func queueDamage(attacker: HeroScene, damageTaken: int):
	damageQueue.push_back(takeDamage.bind(attacker, damageTaken))
	print(damageTaken, " damage has been added to queue")

func takeDamage(attacker: HeroScene, damageTaken: int):
	hp -= damageTaken
	print("damage has been taken, new hp is: ", hp)
	if hp <= 0:
		print ("he dead")

func attack():
	#Tell battlemanager to attack a target
	get_parent().enemyDealAttack(self, preferredTarget, damage)
