class_name BatchTargetCache extends RefCounted
## A temporary cache that complements TargetBehaviorResources when one or more EffectResources should share target selection.

var caster: EntityResource
var caster_index: int
var caster_side: Globals.CasterSide


## A cache of all targets selected by the player for the batch.
var selected_cache: Array[EntityResource] = []

## A list of cached indices corresponding to allies in selected_cache.
var selected_allies: Array[int] = []
## A list of cached indices corresponding to enemies in selected_cache.
var selected_enemies: Array[int] = []

## A cache of all targets selected by the player for the batch.
var random_cache: Array[EntityResource] = []

## A list of cached indices corresponding to allies in selected_cache.
var random_allies: Array[int] = []
## A list of cached indices corresponding to enemies in selected_cache.
var random_enemies: Array[int] = []

func _init(_caster: EntityResource):
	self.caster = _caster
	caster_index = _caster.list_index
	caster_side = _caster.side


## Returns existing targets from the cache, expanding the cache when more targets are requested.
func fetch_targets(behavior: TargetBehaviorResource) -> Array[EntityResource]:
	var to_return: Array[EntityResource] = []
	if behavior.random_target:
		if behavior.shared_target:
			if random_cache.is_empty():
				_populate_random_shared(behavior)
			
			var count = behavior.target_count
			for i in range(count):
				if i < random_cache.size():
					to_return.append(random_cache[i])
				else:
					break
		else:
			if random_allies.is_empty() and random_enemies.is_empty():
				_populate_random_non_shared(behavior)

			var ally_count = behavior.get_ally_target_count()
			for i in range(ally_count):
				if i < random_allies.size():
					var cache_index = random_allies[i]
					to_return.append(random_cache[cache_index])
				else:
					break
			
			var enemy_count = behavior.get_enemy_target_count()
			for i in range(enemy_count):
				if i < random_enemies.size():
					var cache_index = random_enemies[i]
					to_return.append(random_cache[cache_index])
				else:
					break
	else:
		if behavior.shared_target:
			if selected_cache.is_empty():
				_populate_selected_shared(behavior)
			
			var count = behavior.target_count
			for i in range(count):
				if i < selected_cache.size():
					to_return.append(selected_cache[i])
				else:
					break
		else:
			if selected_allies.is_empty() and selected_enemies.is_empty():
				_populate_selected_non_shared(behavior)
			
			var ally_count = behavior.get_ally_target_count()
			for i in range(ally_count):
				if i < selected_allies.size():
					var cache_index = selected_allies[i]
					to_return.append(selected_cache[cache_index])
				else:
					break
			
			var enemy_count = behavior.get_enemy_target_count()
			for i in range(enemy_count):
				if i < selected_enemies.size():
					var cache_index = selected_enemies[i]
					to_return.append(selected_cache[cache_index])
				else:
					break
	return to_return


func _populate_random_shared(behavior: TargetBehaviorResource):
	var eligible_targets = EntityTracker.get_eligible_targets(caster, behavior)
	var count = behavior.target_count
	self.random_cache = EntityTracker.select_random_targets(eligible_targets, count)

func _populate_random_non_shared(behavior: TargetBehaviorResource):
	var ally_behavior = behavior.duplicate()
	ally_behavior.target_enemies = false
	
	var enemy_behavior = behavior.duplicate()
	enemy_behavior.target_allies = false
	enemy_behavior.target_self = false
	
	var eligible_allies = EntityTracker.get_eligible_targets(caster, ally_behavior)
	var eligible_enemies = EntityTracker.get_eligible_targets(caster, enemy_behavior)
	
	var ally_count = behavior.get_ally_target_count()
	var enemy_count = behavior.get_enemy_target_count()
	
	var allies = EntityTracker.select_random_targets(eligible_allies, ally_count)
	var enemies = EntityTracker.select_random_targets(eligible_enemies, enemy_count)
	
	self.random_cache.clear()
	self.random_allies.clear()
	self.random_enemies.clear()
	
	for ally in allies:
		self.random_cache.append(ally)
		self.random_allies.append(self.random_cache.size() - 1)
	
	for enemy in enemies:
		self.random_cache.append(enemy)
		self.random_enemies.append(self.random_cache.size() - 1)

func _populate_selected_shared(behavior: TargetBehaviorResource):
	var eligible_targets = EntityTracker.get_eligible_targets(caster, behavior)
	var count = behavior.target_count
	
	self.selected_cache.clear()
	for i in range(count):
		if i < eligible_targets.size():
			self.selected_cache.append(eligible_targets[i])
		else:
			break

func _populate_selected_non_shared(behavior: TargetBehaviorResource):
	var ally_behavior = behavior.duplicate()
	ally_behavior.target_enemies = false
	
	var enemy_behavior = behavior.duplicate()
	enemy_behavior.target_allies = false
	enemy_behavior.target_self = false
	
	var eligible_allies = EntityTracker.get_eligible_targets(caster, ally_behavior)
	var eligible_enemies = EntityTracker.get_eligible_targets(caster, enemy_behavior)
	
	var ally_count = behavior.get_ally_target_count()
	var enemy_count = behavior.get_enemy_target_count()
	
	self.selected_cache.clear()
	self.selected_allies.clear()
	self.selected_enemies.clear()
	
	for i in range(ally_count):
		if i < eligible_allies.size():
			self.selected_cache.append(eligible_allies[i])
			self.selected_allies.append(self.selected_cache.size() - 1)
		else:
			break
			
	for i in range(enemy_count):
		if i < eligible_enemies.size():
			self.selected_cache.append(eligible_enemies[i])
			self.selected_enemies.append(self.selected_cache.size() - 1)
		else:
			break
