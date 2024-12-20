extends Node
class_name ItemDir

#If those node paths change we're fucked :D
const TEST_ITEM_2 = preload("res://Resources/Items/Card.tres")
const TEST_ITEM_1 = preload("res://Resources/Items/Battle Axe.tres")
const TEST_ITEM = preload("res://Resources/Items/Hammer.tres")

var itemArray: Array[Item] = [TEST_ITEM,TEST_ITEM_1,TEST_ITEM_2]
