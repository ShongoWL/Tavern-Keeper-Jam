extends Node

@export var heroArray:Array[HeroScene] = []

@export var enemyArray:Array[EnemyScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.attack.connect(callAttacker)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func callAttacker(attacker:HeroScene):
	var i = 0
	for hero in heroArray:
		if attacker == hero:
			print("hero ",i, " is attacking")
			hero.attack()
			break
		i += 1

func dealAttack(who:HeroScene, preferredTarget:int, damage:int):
	#check if our preferred target exists. If they don't we should start
	#decrementing the value because enemies will slide down positions when one
	#in front of them dies so that we always have a target
	
	if enemyArray[preferredTarget]:
		enemyArray[preferredTarget].takeDamage(who, damage)
	#If you aren't at the lowest position, recursively call this function for the next position
	elif preferredTarget > 0:
		dealAttack(who, preferredTarget-1, damage)
	else:
		#This should never happen. If there isn't a target to slot into position one, then the fight should be over
		print("Something has gone terribly wrong... How do you not have a target.")
		
