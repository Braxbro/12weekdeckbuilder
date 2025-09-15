class_name TargetedEffectResource extends EffectResource
## Base class for all effects that accept targets.

@export var target_behavior: TargetBehaviorResource

## Trigger the effect. Override this to change the effect.
func invoke_effect(target_cache: BatchTargetCache = BatchTargetCache.new()) -> void:
	print("A TargetedEffectResource has been invoked.")
