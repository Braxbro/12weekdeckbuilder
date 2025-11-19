extends Node

# Enums for sides (copy or import from Globals if needed)
enum CasterSide { GOOD, BAD }

# Entities in play, separated by side
var entities_good: Array[EntityResource] = []
var entities_bad: Array[EntityResource] = []

# --- Entity Registration and Retrieval ---

## Register an entity in play
func register_entity(entity: EntityResource) -> void:
	match entity.side:
		CasterSide.GOOD:
			entities_good.append(entity)
			entity.list_index = entities_good.size() - 1 # list_index set on registration
		CasterSide.BAD:
			entities_bad.append(entity)
			entity.list_index = entities_bad.size() - 1

## Remove an entity from play
func unregister_entity(entity: EntityResource) -> void:
	var list_ref = entities_good if entity.side == CasterSide.GOOD else entities_bad
	list_ref.erase(entity)
	# NOTE: Entity list_index is not updated here for efficiency.
	# Consumers must rely on array iteration or other lookups after unregistering.

## Get all entities on a specific side
func get_side_entities(side: CasterSide) -> Array[EntityResource]:
	return entities_good if side == CasterSide.GOOD else entities_bad

## Get all entities in play
func get_all_entities() -> Array[EntityResource]:
	return entities_good + entities_bad

## Get the opposing side of a given side
func get_opponent_side(side: CasterSide) -> CasterSide:
	return CasterSide.BAD if side == CasterSide.GOOD else CasterSide.GOOD


# --- Target Selection Helpers (CRUCIAL ADDITIONS) ---

## Filters and returns a list of all entities eligible for targeting based on the behavior.
## This is the core logic for finding targets.
func get_eligible_targets(caster: EntityResource, behavior: TargetBehaviorResource) -> Array[EntityResource]:
	var eligible_targets: Array[EntityResource] = []
	var all_entities = get_all_entities()

	for target in all_entities:
		# Mandatory Game Rule Check (e.g., must be alive)
		# if !target.is_alive: 
		# 	continue

		# Check 1: Target Self
		if target == caster:
			if behavior.target_self:
				eligible_targets.append(target)
			continue # Done processing 'self'

		# Check 2: Target Allies
		if target.side == caster.side:
			if behavior.target_allies:
				eligible_targets.append(target)
			continue # Done processing 'ally'

		# Check 3: Target Enemies
		if target.side != caster.side:
			if behavior.target_enemies:
				eligible_targets.append(target)
			# No 'continue' needed as this is the last condition

	return eligible_targets

## Selects a specified number of unique random targets from a pre-filtered eligible list.
## Used by BatchTargetCache to fill its random_cache.
func select_random_targets(eligible_targets: Array[EntityResource], count: int) -> Array[EntityResource]:
	if eligible_targets.is_empty() or count <= 0:
		return []

	# If requesting more targets than available, return all available targets
	if count >= eligible_targets.size():
		return eligible_targets

	var targets: Array[EntityResource] = []
	# Create a working copy of the array to pull from and ensure unique selection
	var pool = eligible_targets.duplicate() 

	for i in range(count):
		if pool.is_empty():
			break
		
		# Select a random index and use pop_at to get the entity AND remove it from the pool
		var index = randi() % pool.size()
		var selected_target = pool.pop_at(index)
		targets.append(selected_target)

	return targets
