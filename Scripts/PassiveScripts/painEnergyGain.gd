class_name painEnergyGain extends Passive

var user: HeroScene
@export var energyGain: int

func setup(hero: HeroScene):
	#print("setting up hpLoss connection in passive")
	SignalBus.hpLoss.connect(onLifeLoss)
	user = hero

func onLifeLoss(victim, damageTaken):
	print("in onLifeLoss")
	if victim == user:
		print(user.charName, " just triggered their 'Hit me harder daddy' passive")
		user.changeEnergy(energyGain)
		
