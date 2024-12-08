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
var energyLevel:float
var energyRegen:int
var charName:String

var maxHp: int

#holds all calls for incoming damage until they can be safely managed
var damageQueue:Array = []

var tween: Tween

func _ready() -> void:
	maxHp = heroData.maxHp
	hp = maxHp
	damage = heroData.damage
	attackCooldown = heroData.attackCooldown
	preferredTarget = heroData.preferredTarget
	critChance = heroData.critChance
	charName = heroData.charName
	energyLevel = 0
	energyRegen = heroData.energyRegen
	
	#Run this at the end of ready to make sure healthBar has access to the right values
	healthBar.initializeValues()
	heroData.passive.setup(self)
	SignalBus.combatOver.connect(combatOver)
	#SignalBus.gainEnergy.connect(energyGain)

func _process(delta: float) -> void:
	#print("the monster's health is now ", hp)
	var tempSize = damageQueue.size()
	for action in damageQueue:
		action.call()
	for number in tempSize:
		damageQueue.pop_front()

func attack():
	#Tell battlemanager to attack a target
	get_parent().heroDealAttack(self, preferredTarget, damage)
	#print("I am attacking!")

func updateHealthbar(newHp: int):
	healthBar.update(newHp)
	hp = newHp
	print(name + "'s hp is now " + str(hp))

func queueDamage(attacker: EnemyScene, damageTaken: int):
	damageQueue.push_back(takeDamage.bind(attacker, damageTaken))
	print(attacker.charName, " has added ",damageTaken, " damage to ", charName, "'s queue")

func takeDamage(attacker: EnemyScene, damageTaken: int):
	if hp - damageTaken <= 0:
		hp -= damageTaken
		#Stop player's timers and remove from array
		SignalBus.hpLoss.emit(self, damageTaken)
		print("hero has died, throwing death signal")
		SignalBus.deathSignal.emit(self, attacker)
		self.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		hp -= damageTaken
		SignalBus.hpLoss.emit(self, damageTaken)
		print(charName," has taken, ", damageTaken," damage, new hp is: ", hp)

func gainEnergy():
	var amountGain = (energyRegen * GlobalVar.minTickRate)
	energyLevel = snapped(energyLevel + amountGain, .1)
	if heroData != null:
		if energyLevel >= heroData.ability.abilityCost:
			print(charName, " spent ", heroData.ability.abilityCost, " to use their ability: ", heroData.ability.abilityName)
			heroData.ability.onEnergyMet(self)
			energyLevel -= heroData.ability.abilityCost
		#else:
			#print(charName, " gained ", amountGain, " energy. Total: ", energyLevel)

#change energy can be positive or negative
func changeEnergy(amountChange: int):
	if amountChange > 0:
		energyLevel += amountChange
		if energyLevel >= heroData.ability.abilityCost:
			print(charName, " spent ", heroData.ability.abilityCost, " to use their ability: ", heroData.ability.abilityName)
			heroData.ability.onEnergyMet(self)
			energyLevel -= heroData.ability.abilityCost
		else:
			print(charName, " gained ", amountChange, " energy. Total: ", energyLevel)
	else:
		if energyLevel - amountChange <= 0:
			energyLevel = 0
		else:
			energyLevel -= amountChange

func takedamage():
	hp -= 10

func combatOver(combatManager, isVictory):
	if combatManager == get_parent():
		self.process_mode = Node.PROCESS_MODE_DISABLED
		print("Combat has ended, ", charName, " is stopping.")

func getHp()->int:
	return hp
