extends Node
@onready var attackTimer: Timer = $AttackTimer
@onready var energyTimer: Timer = $EnergyTimer

var parentHero: Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parentHero = get_parent()
	attackTimer.wait_time = parentHero.heroData.attackCooldown
	
	attackTimer.start()
	energyTimer.start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sendAttackSignal():
	#print("My hero is attacking!!!")
	SignalBus.attack.emit(parentHero)

func sendGainEnergySignal():
	#print("My hero is gaining Energy!")
	SignalBus.gainEnergy.emit(parentHero)
