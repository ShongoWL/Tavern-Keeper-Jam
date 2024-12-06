extends Node
@onready var attackTimer: Timer = $AttackTimer
var parentHero: Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parentHero = get_parent()
	attackTimer.wait_time = parentHero.attackCooldown
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
