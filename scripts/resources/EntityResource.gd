class_name EntityResource extends Resource

#Currently a placeholder class

## Stores the entity's side for use in effects it casts.
var side: Globals.CasterSide

## Stores the entity's ModifierState. Read-only; use ModifierState's methods to modify the state.
var modifiers: ModifierState = ModifierState.new():
	set(value):
		pass

## Stores the entity's index in its side's array.
var list_index: int


#TODO: Implement class according to needs of EffectResources.
