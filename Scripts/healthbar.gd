extends ProgressBar
class_name Healthbar

#When attaching this healthbar to a scene, you need to drag that scene's parent into this export box
@export var parental: Node2D
@onready var label: Label = $Label

var tween: Tween

var labelHp: int

func initializeValues() -> void:
	SignalBus.maxHpGained.connect(maxHpIncreased)
	
	max_value = parental.maxHp #change to max hp
	value = max_value
	labelHp = value
	label.text = str(labelHp)+"/"+str(max_value)

func _process(_delta: float) -> void:
	#This makes the text descend 1 every frame
	if labelHp != value:
		if labelHp > value:
			labelHp -= 1
			label.text = str(labelHp)+"/"+str(max_value)
		if labelHp < value:
			labelHp += 1
			label.text = str(labelHp)+"/"+str(max_value)

func update(newValue: int):
	tween = create_tween()
	tween.tween_property(self, "value", newValue, 0.5)

func maxHpIncreased(who, amount: int):
	if parental == who:
		max_value += amount
		value += amount
