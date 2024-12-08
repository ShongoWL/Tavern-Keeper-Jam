extends Node
class_name ShopScene

@onready var shopUI: Control = $ShopUI
@onready var itemList: itemList = $ItemList

@export var testItem: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_items()


func generate_items():
	for bag in itemList.itemArray:
		shopUI.add_item(bag)
