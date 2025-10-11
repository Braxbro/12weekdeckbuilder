class_name TargetBehaviorResource extends Resource
## A data structure that controls common targeting behaviors.


# signals
# enums
## TargetFlags is accessible from Globals.gd - it's proxied here for convenience.
const Flags = Globals.TargetFlags

# constants
# static variables

# export variables
@export_group("Target Mask")
## Can target its user.
@export var target_self: bool
## Can target its user's allies.
@export var target_allies: bool
## Can target its user's enemies.
@export var target_enemies: bool

@export_group("Multi-target")
## Targets randomly and does not present a choice to the player. Should be true when target_count, ally_count, or enemy_count are greater than 1.
## To avoid superfluous operations, is ignored when the number of targets matches or exceeds the number of eligible targets.
@export var random_target: bool = true
## Counts all targets towards the same limit. If target_self is true, its user will always be targeted when shared_target is false.
@export var shared_target: bool = true
## The number of targets to be targeted. Must be 1 or more. Use the maximum value when targeting all targets.
@export_range(1, Globals.max_target_count, 1, "hide_slider") var target_count: int = 1

# No self_count exists, as there can be only one user.

## If shared_count is false, this value overrides target_count when targeting allies. When less than 1, proxies target_count.
@export_range(0, Globals.max_ally_count, 1, "hide_slider") var ally_count: int = 0

## If shared_count is false, this value overrides target_count when targeting enemies. When less than 1, proxies target_count.
@export_range(0, Globals.max_enemy_count, 1, "hide_slider") var enemy_count: int = 0


@export_group("Repetition")
## When targeting, applies targeting multiple times, without de-duplication - targets can be selected multiple times in different targeting passes.
@export_range(1, 1, 1, "hide_slider", "or_greater") var pass_count: int

# regular variables
# onready variables


# _static_init()
# static functions

# overridden virtual methods - _init, _enter_tree, _ready, _process, _physics_process, others in that order
## Constructor. target_mask is an integer sum of one or more TargetFlags.
func _init(
	target_mask: int = 
		Flags.TARGET_ENEMIES + Flags.TARGET_SHARED, 
	targets: int = 1, 
	allies: int = 0, 
	enemies: int = 0, 
	repeat: int = 1
) -> void:
	pass_count = repeat if repeat > 0 else 1
	set_target_flags(target_mask)
	target_count = targets
	ally_count = allies
	enemy_count = enemies
	pass_count = repeat

# overridden custom methods

# remaining methods
## Returns false when using shared targeting; otherwise, returns the number of allies that should be targeted.
func get_ally_target_count():
	if !shared_target:
		return ally_count if ally_count > 0 else target_count
	return false

## Returns false when using shared targeting; otherwise, returns the number of allies that should be targeted.
func get_enemy_target_count():
	if !shared_target:
		return enemy_count if enemy_count > 0 else target_count
	return false
	
## A setter to quickly set target mask using bit flags, instead of setting related booleans one by one.
func set_target_flags(target_mask: int) -> void:
	# Ignored, but will still warn to assist in streamlining code.
	if target_mask >= 2**5: push_warning("TargetBehaviorResource assigned one or more useless target flags.")
	target_self = (target_mask & Flags.TARGET_SELF) != 0
	target_allies = (target_mask & Flags.TARGET_ALLIES) != 0
	target_enemies = (target_mask & Flags.TARGET_ENEMIES) != 0
	random_target = (target_mask & Flags.TARGET_RANDOM) != 0
	shared_target = (target_mask & Flags.TARGET_SHARED) != 0

# subclasses
