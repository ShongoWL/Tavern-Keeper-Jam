extends Control
class_name ShopUI

@onready var gridContainer: GridContainer = $MarginContainer/GridContainer

@onready var shopPanelArray: Array[Node] = gridContainer.get_children()

func add_item(bag: Item) -> ItemPanel:
	for hole in shopPanelArray:
		if hole.itemHeld:
			continue
		else:
			hole.itemHeld = bag
			hole.updateItem()
			print(hole.name + " has been bestowed " + bag.itemName)
			return hole
	
	return null
