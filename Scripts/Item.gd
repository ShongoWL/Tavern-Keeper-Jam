extends Resource
class_name Item

@export var itemName: String
@export var price: int
@export var sprite: Texture
@export_enum("Common", "Uncommon", "Rare", "Mythic") var Rarity: String

@export var itemAbility: Script
