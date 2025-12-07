class_name ModifierState extends Resource

class Modifier extends Resource:
	## A simple data class for modifying effects.
	
	## The locale_key of the EffectResource type the Modifier applies to.
	var locale_key: String
	
	## The value of the modifier. Effect varies depending on effect type.
	var value: int = 1
	
	## The number of times the modifier can be applied before expiring.
	var count: int = 1

var current_modifiers: Dictionary[String, Array] = {}

## Add a new modifier to the ModifierState.
func add_modifier(modifier: ModifierState.Modifier) -> void:
	# This is ugly af. Essentially, just ensures that current_modifiers contains the appropriate
	# sub-array and that said array is properly treated as an Array[ModifierState.Modifier] when assigning values.
	(current_modifiers.get_or_add(modifier.locale_key, [] as Array[ModifierState.Modifier]) as Array[ModifierState.Modifier]).append(modifier)

func get_modifier_total(locale_key: String) -> int:
	var total_value: int = 0
	# Similar deal. Ensures that the array is fetched as an Array[ModifierState.Modifier].
	var filtered_modifiers = (current_modifiers[locale_key] as Array[ModifierState.Modifier])
	for i in filtered_modifiers.size():
		total_value += filtered_modifiers[i].value
		filtered_modifiers[i].count -= 1
		if filtered_modifiers[i].count <= 0:
			filtered_modifiers.remove_at(i)
			i -= 1
	return total_value
