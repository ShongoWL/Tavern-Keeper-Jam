class_name BattleManager extends Node2D

@onready var heroGroup: Node = %HeroGroup
@onready var enemyGroup: Node = %EnemyGroup

@onready var heroArray:Array[HeroScene] = []
@onready var enemyArray:Array[EnemyScene] = [] ##A, I changed these to onready
## vars so we don't need to export them by hand. Now in the ready function
## battlemanager accesses the HeroGroup & EnemyGroup nodes to fill the arrays

var timerArray:Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.timeToAttack.connect(callAttacker)
	SignalBus.deathSignal.connect(deathNotif)
	SignalBus.gainEnergy.connect(callEnergyGain)
	
	for i in heroGroup.get_children():
		if i is HeroScene:
			heroArray.append(i)
	
	for i in enemyGroup.get_children():
		if i is EnemyScene:
			enemyArray.append(i)
	
	await get_tree().create_timer(0.2).timeout
	timerArray = get_tree().get_nodes_in_group("Timers")
	for i in timerArray:
		i.startFight()
	


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
	var totalDamage = calculateDamage(attacker, damage)
	if enemyArray.size() == 0:
		return
	if preferredTarget > enemyArray.size()-1:
		enemyArray[enemyArray.size()-1].queueDamage(attacker, totalDamage)
	else:
		enemyArray[preferredTarget].queueDamage(attacker, totalDamage)

func enemyDealAttack(attacker:EnemyScene, preferredTarget:int, damage:int):
	if heroArray.size() == 0:
		print("There are no heroes left to attack!")
		print("Player has been defeated! D:")
		return
	if preferredTarget > heroArray.size()-1:
		heroArray[heroArray.size()-1].queueDamage(attacker, damage)
	else:
		heroArray[preferredTarget].queueDamage(attacker, damage)

func calculateDamage(attacker: HeroScene, damage) -> int:
	var finalDamage: int = damage
	var isCrit = rollCrit(attacker)
	if isCrit == true:
		finalDamage = damage*attacker.heroData.critModifier
	return finalDamage

func rollCrit(attacker: HeroScene) -> bool:
	var isCrit = false
	var diceRoll = randi_range(1,100)
	print("Rolled: ", diceRoll, ". Need ", attacker.critChance, " or lower to crit")
	if diceRoll <= attacker.critChance:
		isCrit = true
		print("OH MY GOD, YOU CRIT YOU MADMAN!!!")
	return isCrit

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


func combatOver(combat:BattleManager, isVictory: bool):##A, I messed with this so the heroes and 
	## enemies won't need to listen for a signal
	SignalBus.combatOver.emit(combat, isVictory)
	
	for i in heroGroup.get_children(): 
		i.combatOver(isVictory)
	for i in enemyGroup.get_children():
		i.combatOver(isVictory)
	
	if isVictory:
		print("The heroes won!!!")
	else:
		print("The heroes lost!!!")
