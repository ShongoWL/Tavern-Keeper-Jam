extends Node
@onready var attackTimer: Timer = $AttackTimer
@onready var energyTimer: Timer = $EnergyTimer

#var parentHero: Node
var parentEntity: Node


# Called when the node enters the scene tree for the first time.
"""func _ready() -> void:
	parentEntity = get_parent()
	if parentEntity is HeroScene:
		attackTimer.wait_time = parentEntity.heroData.attackCooldown
		energyTimer.start()
	else:
		attackTimer.wait_time = parentEntity.enemyData.attackCooldown
	attackTimer.start()"""

func startFight() -> void:
	parentEntity = get_parent()
	if parentEntity is HeroScene:
		attackTimer.wait_time = parentEntity.heroData.attackCooldown
		energyTimer.start()
	else:
		attackTimer.wait_time = parentEntity.enemyData.attackCooldown
	attackTimer.start()


func sendAttackSignal():
	SignalBus.timeToAttack.emit(parentEntity, parentEntity.preferredTarget, parentEntity.damage)

func sendGainEnergySignal():
	#print("sending energy signal")
	SignalBus.gainEnergy.emit(parentEntity)
