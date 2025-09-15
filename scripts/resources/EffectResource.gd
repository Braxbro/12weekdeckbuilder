class_name EffectResource extends Resource
## Base class for all effects.

# EffectResources have no target. Their child, TargetedEffectResources, do.

#TODO: replace this with a mask of colors
## The color the effect is counted as. When the color does not match the light, visibility on cards will be reduced; a perfect match with no extra colors increases visibility.
var color: String = "white":
	set(new_value):
		pass
## The key used to describe the effect in tooltips.
var locale_key: String = "EFFECT_DEBUG": 
	set(new_value):
		pass

@export var debug_string: String = "Debug Effect"

## Trigger the effect. Override this to change the effect.
func invoke_effect() -> void:
	print("An EffectResource has been invoked.")
