extends ProgressBar

@onready var hero: HeroScene = $".."
@onready var label: Label = $Label

var tween: Tween

var labelHp: int

func initializeValues() -> void:
	#Set max value of healthBar to hp, if we ever increase a character's max hp mid fight this will
	#need to be set again or it won't display correctly
	max_value = hero.heroData.hp #change to max hp
	value = hero.hp
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

func maxHpIncreased():
	pass #Write this later, after we've added a max HP variable
