extends Control
class_name ShopPanel

@onready var itemSprite: TextureRect = $ItemSprite

var itemHeld: Item

func _ready() -> void:
	if itemHeld:
		itemSprite.texture = itemHeld.sprite
		itemSprite.visible = true

#add a little money tag for price

func updateItem():
	if itemHeld:
		itemSprite.texture = itemHeld.sprite
		itemSprite.visible = true
		print(itemHeld.itemName)
