extends Resource
class_name Entity

#Export Values
@export var maxHp: int
@export var damage: int
@export var attackCooldown: float
@export var charName: String


@export var preferredTarget: int = 0

#Non export values
var hp: int

func _init() -> void:
	hp = maxHp
