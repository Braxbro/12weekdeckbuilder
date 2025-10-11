class_name TargetedEffectResource extends EffectResource
## Base class for all effects that accept targets.

@export var target_behavior: TargetBehaviorResource

## Trigger the effect. Override this to change the effect.
func invoke_effect(target_cache: BatchTargetCache = BatchTargetCache.new()) -> void:
	## Warn because bare TargetedEffectResource should not be used on actual cards, but may be used for testing
	push_warning("A TargetedEffectResource has been invoked.")
