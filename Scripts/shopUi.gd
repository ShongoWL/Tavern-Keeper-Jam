extends Control
class_name ShopUI

@onready var gridContainer: GridContainer = $MarginContainer/GridContainer

@onready var shopPanelArray: Array[Node] = gridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(bag: Item) -> ShopPanel:
	for hole in shopPanelArray:
		if hole.itemHeld:
			continue
		else:
			hole.itemHeld = bag
			hole.updateItem()
			print(hole.name + " has been bestowed " + bag.itemName)
			return hole
	
	return null
