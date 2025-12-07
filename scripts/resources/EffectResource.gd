class_name EffectResource extends Resource
## Base class for all effects.

# EffectResources have no target. Their child, TargetedEffectResources, do.

#TODO: replace this with a mask of colors
## The color the effect is counted as. When the color does not match the light, visibility on cards will be reduced; a perfect match with no extra colors increases visibility.
var color: String = "white":
	set(new_value):
		pass
## The key used to describe the effect in tooltips. Should be unique.
var locale_key: String = "DEBUG_EFFECT": 
	set(new_value):
		pass

## Trigger the effect. Override this to change the effect.
func invoke_effect() -> void:
	## Warn because bare EffectResource should not be used on actual cards, but may be used for testing
	push_warning("A debug EffectResource has been invoked.")
