class_name CardEffectResource extends Resource

enum TargetType {TARGET_NONE, TARGET_SELF, TARGET_ALLIES, TARGET_ENEMIES}
@export var target: TargetType = TargetType.TARGET_NONE

func invoke_effect():
	print("A CardEffectResource has been invoked.")
