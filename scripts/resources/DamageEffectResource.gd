extends TargetedEffectResource
class_name DamageEffectResource
@export var damage_effect: Array[Dictionary] = [
	{"amount": 10, "type": "default"}
]
func _apply_effect_to_target(user: Node,target:Node) ->void:
	if not target.has_method("apply_damage"):
		return

	for entry in damage_effect:
		var amount = entry.get("amount",0)
		var dtype = entry.get("type","default")
		target.apply_damage(amount,user, dtype)
