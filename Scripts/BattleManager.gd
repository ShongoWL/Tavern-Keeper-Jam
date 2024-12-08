class_name BattleManager extends Node2D

@export var heroArray:Array[HeroScene] = []

@export var enemyArray:Array[EnemyScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.timeToAttack.connect(callAttacker)
	SignalBus.deathSignal.connect(deathNotif)
	SignalBus.gainEnergy.connect(callEnergyGain)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#This function checks to see if hero or enemy is attacking then loops through proper array to find them
func callAttacker(attacker:Node, preferredTarget:int, damage:int):
	if attacker is HeroScene && attacker in heroArray:
		heroDealAttack(attacker, preferredTarget, damage)
	elif attacker is EnemyScene && attacker in enemyArray: 
		enemyDealAttack(attacker, preferredTarget, damage)
	else:
		pass
		#print("Yo dog, how did you fuck this up? Attacker is not a hero or enemy???")

func callEnergyGain(target: HeroScene):
	if target in heroArray:
		target.gainEnergy()

func heroDealAttack(attacker:HeroScene, preferredTarget:int, damage:int):
	if enemyArray.size() == 0:
		return
	if preferredTarget > enemyArray.size()-1:
		enemyArray[enemyArray.size()-1].queueDamage(attacker, damage)
	else:
		enemyArray[preferredTarget].queueDamage(attacker, damage)

func enemyDealAttack(attacker:EnemyScene, preferredTarget:int, damage:int):
	if heroArray.size() == 0:
		print("There are no heroes left to attack!")
		print("Player has been defeated! D:")
		return
	if preferredTarget > heroArray.size()-1:
		heroArray[heroArray.size()-1].queueDamage(attacker, damage)
	else:
		heroArray[preferredTarget].queueDamage(attacker, damage)
		


func deathNotif(victim, killer):
	if victim is HeroScene:
		#make new array because safer than deleting from array while iterating
		var tempHeroArray:Array[HeroScene] = []
		for hero in heroArray:
			#if not the victim, they are still alive and need to be in our new array
			if hero != victim:
				tempHeroArray.append(hero)
		#now our main HeroArray should be one element shorter without the victim
		heroArray = tempHeroArray
		if heroArray.is_empty():
			combatOver(self, false)
	#Same proccess as above but for enemies. (Code is repeated here beccause of array typings being annoying)
	else:
		var tempEnemyArray:Array[EnemyScene] = []
		for enemy in enemyArray:
			if enemy != victim:
				tempEnemyArray.append(enemy)
		enemyArray = tempEnemyArray
		if enemyArray.is_empty():
			combatOver(self, true)


func combatOver(combat:BattleManager, isVictory: bool):
	SignalBus.combatOver.emit(combat, isVictory)
	if isVictory:
		print("The heroes won!!!")
	else:
		print("The heroes lost!!!")
