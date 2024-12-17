class_name painEnergyGain extends Passive

var user: HeroScene
@export var energyGain: int

func _init() -> void:
	SignalBus.hpLoss.connect(onLifeLoss)
	print("setting up hpLoss connection in passive")

func setup(hero: HeroScene):
	user = hero

func onLifeLoss(victim, damageTaken):
	print("in onLifeLoss")
	if victim == user:
		print(user.charName, " just triggered their 'Hit me harder daddy' passive")
		user.changeEnergy(energyGain)
