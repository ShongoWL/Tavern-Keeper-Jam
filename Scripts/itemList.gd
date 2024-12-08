extends Node
class_name itemList

#If those node paths change we're fucked :D
const TEST_ITEM_2 = preload("res://Resources/Items/testItem2.tres")
const TEST_ITEM_1 = preload("res://Resources/Items/testItem1.tres")
const TEST_ITEM = preload("res://Resources/Items/testItem.tres")

var itemArray: Array[Item] = [TEST_ITEM,TEST_ITEM_1,TEST_ITEM_2]
