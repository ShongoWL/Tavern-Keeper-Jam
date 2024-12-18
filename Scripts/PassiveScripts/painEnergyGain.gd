class_name painEnergyGain extends Passive

var user: HeroScene
@export var energyGain: int

func setup(hero: HeroScene):
	SignalBus.hpLoss.connect(onLifeLoss)
	print("setting up hpLoss connection in passive")
	user = hero

func onLifeLoss(victim: Object, damageTaken):
	print("in onLifeLoss" + user.name)
	if victim == user:
		print(user.charName, " just triggered their 'Hit me harder daddy' passive")
		user.changeEnergy(energyGain)
	else:
		print("victim was" + victim.name)
