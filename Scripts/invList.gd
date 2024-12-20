extends ItemListScript
class_name InvList

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Item and get_item_at_position(at_position,true) == -1:
		if data.holder is ShopList and GlobalVar.playerGold >= data.price:
			return true
		elif data.holder is ItemList:
			return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data.holder is ShopList:
		GlobalVar.playerGold -= data.price
		print("paid " + str(data.price) + " for " + data.itemName)
		SignalBus.itemBought.emit(data, data.price) ## I go ahead and pay the price here, then
		## emit itemBought in case we have things that trigger on buy
	
	addItem(data)
