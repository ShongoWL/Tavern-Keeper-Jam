extends Node2D
class_name EnemyScene

@export var enemyData: Entity

@export var hp:int 
@export var damage:int
@export var attackCooldown:float


func _ready() -> void:
	hp = enemyData.hp
	damage = enemyData.damage
	attackCooldown = enemyData.damage


func takeDamage(attacker: HeroScene, damageTaken: int):
	hp -= damageTaken
	print("the monster's health is now ", hp)
	if hp <= 0:
		print ("Oh my god, ", attacker, " killed the monster :O")
		SignalBus.deathSignal.emit(self, attacker)
