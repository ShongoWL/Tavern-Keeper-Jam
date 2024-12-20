extends ItemList
class_name ItemListScript

func searchByMetadata(itemMeta: Item) -> int: ##Pass in metadata and this function gives you the first item found's index
	for i in item_count - 1:
		if get_item_metadata(i) == itemMeta:
			return i
			break
		else:
			continue
	return -1

func addItem(item: Item) -> void: ## Removes item from previous holder, adds item, metadata
	if item.holder:
		item.holder.remove_item(item.holder.searchByMetadata(item))
	
	add_item(item.itemName,item.sprite, true)
	set_item_metadata(item_count - 1, item)
	item.holder = self


func _get_drag_data(at_position: Vector2) -> Item: ##A, I believe this code is right but for some
	##reason in main the shopScene and the userInterface fight each other and depending on the way they're
	##set up one or the other won't receive ANY inputs?????
	
	##A, I figured it out, weirdness with control nodes. Long story short, a node that was supposed
	## to just be "node" was actually "control" and it was blocking inputs
	var clickedIndex: int = get_item_at_position(at_position, true)
	
	var dragPre = TextureRect.new()
	dragPre.texture = get_item_icon(clickedIndex)
	dragPre.z_index = 8
	set_drag_preview(dragPre)
	return get_item_metadata(clickedIndex)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Item and get_item_at_position(at_position,true) == -1:
		return true
	else:
		return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	addItem(data)
