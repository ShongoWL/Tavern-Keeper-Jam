class_name perfect extends Passive
##It's a verb not an adjective

var user: HeroScene
@export var energyGainedPer5Spent: int = 2

func setup(hero: HeroScene):
	#print("setting up hpLoss connection in passive")
	SignalBus.energySpent.connect(onAllyEnergySpent)
	user = hero

func onAllyEnergySpent(who, amountSpent):
	if who == user or who != HeroScene:
		return
	var amountToGain: int = amountSpent % 5
	amountToGain *= energyGainedPer5Spent
	user.changeEnergy(amountToGain)
	print(user.charName, " just triggered their passive")
	
