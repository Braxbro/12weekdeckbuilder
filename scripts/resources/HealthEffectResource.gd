extends TargetedEffectResource
class_name HealthEffectResource
@export var heal_effect: Array[Dictionary] = [
	{"amount": 10, "type": "default"}
]
func _apply_effect_to_target(user: Node,target:Node) ->void:
	if not target.has_method("apply_health"):
		return

	for entry in heal_effect:
		var amount = entry.get("amount",0)
		var dtype = entry.get("type","default")
		target.apply_health(amount,user, dtype)
