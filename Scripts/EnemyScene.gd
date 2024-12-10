extends Node2D
class_name EnemyScene

@export var enemyData: Entity

@onready var healthBar: Healthbar = $Healthbar

var damageQueue:Array = []

var hp:int : set = updateHealthbar
var maxHp: int
var damage:int
var attackCooldown:float
var preferredTarget:int
var charName:String

var tween: Tween
var lock: bool = false

func _ready() -> void:
	maxHp = enemyData.maxHp
	hp = maxHp
	damage = enemyData.damage
	attackCooldown = enemyData.damage
	preferredTarget = enemyData.preferredTarget
	charName = enemyData.charName
	
	healthBar.initializeValues()
	SignalBus.combatOver.connect(combatOver)

func _process(delta: float) -> void:
	#print("the monster's health is now ", hp)
	var tempSize = damageQueue.size()
	for action in damageQueue:
		action.call()
	for number in tempSize:
		damageQueue.pop_front()

func queueDamage(attacker: HeroScene, damageTaken: int):
	damageQueue.push_back(takeDamage.bind(attacker, damageTaken))
	print(attacker.charName, " has added ",damageTaken, " damage to ", charName, "'s queue")

func takeDamage(attacker: HeroScene, damageTaken: int):
	if hp - damageTaken <= 0:
		hp = 0
		#Stop player's timers and remove from array
		print("enemy has died, throwing death signal")
		SignalBus.deathSignal.emit(self, attacker)
		damageQueue.clear()
		self.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		hp -= damageTaken
		print(charName, " has been hit for ", damageTaken," damage, new hp is: ", hp)

func attack():
	#Tell battlemanager to attack a target
	get_parent().enemyDealAttack(self, preferredTarget, damage)
	
func combatOver(combatManager, isVictory):
	if combatManager == get_parent():
		self.process_mode = Node.PROCESS_MODE_DISABLED
		print("Combat has ended, ", charName, " is stopping.")

func updateHealthbar(newHp: int):
	healthBar.update(newHp)
	hp = newHp
	print(name + "'s hp is now " + str(hp))
