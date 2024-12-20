extends Control
class_name ShopUI

@onready var itemList: ItemList = $MarginContainer/ItemList

func add_item(bag: Item) -> void:
	itemList.addItem(bag)
	
	print(itemList.name + " has been bestowed " + bag.itemName)
