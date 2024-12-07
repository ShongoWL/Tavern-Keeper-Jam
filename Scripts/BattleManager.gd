extends Node

@export var heroArray:Array[HeroScene] = []

@export var enemyArray:Array[EnemyScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.timeToAttack.connect(callAttacker)
	SignalBus.deathSignal.connect(deathNotif)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#This function checks to see if hero or enemy is attacking then loops through proper array to find them
func callAttacker(attacker:Node, preferredTarget:int, damage:int):
	if attacker is HeroScene:
		heroDealAttack(attacker, preferredTarget, damage)
	elif attacker is EnemyScene: 
		enemyDealAttack(attacker, preferredTarget, damage)
	else:
		print("Yo dog, how did you fuck this up? Attacker is not a hero ouu")
	"""var i = 0
	if attacker is HeroScene:
		for hero in heroArray:
			if attacker == hero:
				#print("hero ",i, " is attacking")
				hero.attack()
				break
			i += 1
	else:
		for enemy in enemyArray:
			if attacker == enemy:
				#print("enemy ",i, " is attacking")
				enemy.attack()
				break
			i += 1"""

func heroDealAttack(attacker:HeroScene, preferredTarget:int, damage:int):
	if enemyArray.size() == 0:
		return
	if preferredTarget > enemyArray.size()-1:
		enemyArray[enemyArray.size()-1].queueDamage(attacker, damage)
	else:
		enemyArray[preferredTarget].queueDamage(attacker, damage)
	"""#check if our preferred target exists. If they don't we should start
	#decrementing the target because enemies will slide down positions when one
	#in front of them dies so that we always have a target
	if enemyArray.size() == 0:
		print("There are no enemies left to attack!")
		return
	if preferredTarget <= enemyArray.size()-1:
		enemyArray[preferredTarget].takeDamage(attacker, damage)
	#If you aren't at the lowest position, recursively call this function for the next position
	elif preferredTarget > 0:
		heroDealAttack(attacker, preferredTarget-1, damage)
	else:
		#This should never happen. If there isn't a target to slot into position one, then the fight should be over
		print("Enemies have been defeated! :D")"""

func enemyDealAttack(attacker:EnemyScene, preferredTarget:int, damage:int):
	if heroArray.size() == 0:
		print("There are no heroes left to attack!")
		pass
	if preferredTarget <= heroArray.size()-1:
		heroArray[preferredTarget].takeDamage(attacker, damage)
	elif preferredTarget > 0:
		enemyDealAttack(attacker, preferredTarget-1, damage)
	else:
		print("Players have beend defeated! D:")


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
	#Same proccess as above but for enemies. (Code is repeated here beccause of array typings being annoying)
	else:
		var tempEnemyArray:Array[EnemyScene] = []
		for enemy in enemyArray:
			if enemy != victim:
				tempEnemyArray.append(enemy)
		enemyArray = tempEnemyArray
