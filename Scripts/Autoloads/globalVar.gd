extends Node

var minTickRate: float = 0.1

var playerGold: int = 99
var rent: int

var inventory: Array[Item] = []

var existingHeros: Array[Hero] = []

#This is an enum of constants for the various states of time, trying to come up with a better name than "PARTY" for when the heros arrive
enum timeState{MORNING, QUESTS, SHOP, PARTY, FIGHT, NIGHT}
