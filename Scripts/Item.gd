extends Resource
class_name Item

@export var itemName: String
@export var price: int
@export var sprite: Texture
@export_enum("Common", "Uncommon", "Rare", "Mythic") var Rarity: String

@export var itemAbility: Script

var holder: ItemList ##This allows us to set an items holder so we can access the holder
var index: int
