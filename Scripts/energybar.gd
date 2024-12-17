extends ProgressBar
class_name EnergyBar

#When attaching this healthbar to a scene, you need to drag that scene's parent into this export box
@export var parental: Node2D
@onready var label: Label = $Label

var tween: Tween

var labelEnergy: int

func initializeValues() -> void:
	max_value = parental.abilityCost
	value = 0
	labelEnergy = value
	label.text = str(labelEnergy)+"/"+str(max_value)

func _physics_process(delta: float) -> void:
	#This makes the text descend 1 every frame
	if labelEnergy != value:
		if labelEnergy > value:
			labelEnergy -= 1
			label.text = str(labelEnergy)+"/"+str(max_value)
		if labelEnergy < value:
			labelEnergy += 1
			label.text = str(labelEnergy)+"/"+str(max_value)

func update(newValue: float):
	value = newValue
