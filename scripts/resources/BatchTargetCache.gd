class_name BatchTargetCache extends RefCounted
## A temporary cache that complements TargetBehaviorResources when one or more EffectResources should share target selection.

var caster: EntityResource
var caster_index: int
var caster_side: Globals.CasterSide


#TODO: Create resource type for all entities to make this type tag more specific
## A cache of all targets selected by the player for the batch.
var selected_cache: Array[EntityResource] = []

## A list of cached indices corresponding to allies in selected_cache.
var selected_allies: Array[int] = []
## A list of cached indices corresponding to enemies in selected_cache.
var selected_enemies: Array[int] = []

#TODO: Create resource type for all entities to make this type tag more specific
## A cache of all targets selected by the player for the batch.
var random_cache: Array[EntityResource] = []

## A list of cached indices corresponding to allies in selected_cache.
var random_allies: Array[int] = []
## A list of cached indices corresponding to enemies in selected_cache.
var random_enemies: Array[int] = []

func _init(caster: EntityResource):
	self.caster = caster
	caster_index = caster.list_index
	caster_side = caster.side


## Returns existing targets from the cache, expanding the cache when more targets are requested.
func fetch_targets(behavior: TargetBehaviorResource) -> Array[EntityResource]:
	var to_return: Array = []
	if behavior.random_target:
		if behavior.shared_target:
			for i: int in range(behavior.target_count):
				if i < random_cache.size():
					to_return.append(random_cache[i])
				else:
					#TODO: Finish implementing target fetching logic
					pass
		else:
			for i: int in range(behavior.get_ally_target_count()):
				if i < random_allies.size():
					to_return.append(random_cache[random_allies[i]])
				else:
					#TODO: Finish implementing target fetching logic
					pass
			for i: int in range(behavior.get_enemy_target_count()):
				if i < random_enemies.size():
					to_return.append(random_cache[random_enemies[i]])
				else:
					#TODO: Finish implementing target fetching logic
					pass
	else:
		if behavior.shared_target:
			for i: int in range(behavior.target_count):
				if i < selected_cache.size():
					to_return.append(selected_cache[i])
				else:
					#TODO: Finish implementing target fetching logic
					pass
		else:
			for i: int in range(behavior.get_ally_target_count()):
				if i < selected_allies.size():
					to_return.append(selected_cache[selected_allies[i]])
				else:
					#TODO: Finish implementing target fetching logic
					pass
			for i: int in range(behavior.get_enemy_target_count()):
				if i < selected_enemies.size():
					to_return.append(selected_cache[selected_enemies[i]])
				else:
					#TODO: Finish implementing target fetching logic
					pass
	return to_return
