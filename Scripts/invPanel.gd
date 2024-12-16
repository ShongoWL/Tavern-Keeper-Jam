extends ItemPanel
class_name InvPanel

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Item and itemHeld == null:
		if data.holder is ShopPanel and GlobalVar.playerGold >= data.price:
			return true
		elif data.holder is ItemPanel:
			return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data.holder is ShopPanel:
		GlobalVar.playerGold -= data.price
		print("paid " + str(data.price) + " for " + data.itemName)
		SignalBus.itemBought.emit(data, data.price) ## I go ahead and pay the price here, then
		## emit itemBought in case we have things that trigger on buy
	data.holder.removeItem()
	
	itemHeld = data
	updateItem()
