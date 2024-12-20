extends TimeOfDay
class_name ShopScene

@onready var shopUI: Control = $ShopUI
@onready var itemDir: ItemDir = $ItemDir

@export var testItem: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_items()


func generate_items():
	for bag in itemDir.itemArray:
		shopUI.add_item(bag)
