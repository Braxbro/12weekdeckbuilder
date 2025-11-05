class_name EntityResource extends Resource

## Which side the entity belongs to.
var side: Globals.CasterSide

## Position index within its side's list.
var list_index: int

## Placeholder stats — expand later (HP, mana, etc.)
var stats := {}

func _init(_side := Globals.CasterSide.GOOD, _stats := {}):
	side = _side
	stats = _stats
