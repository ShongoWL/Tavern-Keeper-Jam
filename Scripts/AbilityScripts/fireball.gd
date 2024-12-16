class_name fireball
extends Ability

var fireballDamage: int = 100

#Bulk up will increas attack power and crit chance of it's user
func onEnergyMet(user: HeroScene, _enemyArray: Array):
	if _enemyArray.size() == 0:
		return
	
	var x: int = 0
	for i in _enemyArray:
		if x > 2:
			break
		i.queueDamage(user,fireballDamage)
		x += 1
		print(i.charName + " was singed by " + str(fireballDamage) + " points of fireball damage!")
	
	##This is the complicated way I did it originally
	"""_enemyArray[0].queueDamage(user,fireballDamage)
	print(_enemyArray[0].charName + " was singed by " + str(fireballDamage) + " of fireball damage!")
	if _enemyArray[1]:
		_enemyArray[1].queueDamage(user,fireballDamage)
		print(_enemyArray[1].charName + " was singed by " + str(fireballDamage) + " of fireball damage!")
	if _enemyArray[2]:
		_enemyArray[2].queueDamage(user,fireballDamage)
		print(_enemyArray[2].charName + " was singed by " + str(fireballDamage) + " of fireball damage!")"""
