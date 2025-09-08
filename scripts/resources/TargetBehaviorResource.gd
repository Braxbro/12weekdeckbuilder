@tool
class_name TargetBehaviorResource extends Resource
## A data structure that controls common targeting behaviors.


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
## Counts all targets towards the same limit. If target_self is true, its user will always be targeted when shared_count is false.
@export var shared_count: bool = true
## The number of targets to be targeted. Must be 1 or more. Use the maximum value when targeting all targets.
@export_range(1, Globals.max_target_count, 1, "hide_slider") var target_count: int = 1

# No self_count exists, as there can be only one user.

## If shared_count is false, this value overrides target_count when targeting allies. When less than 1, proxies target_count.
@export_range(0, Globals.max_ally_count, 1, "hide_slider") var ally_count: int

## If shared_count is false, this value overrides target_count when targeting enemies. When less than 1, proxies target_count.
@export_range(0, Globals.max_enemy_count, 1, "hide_slider") var enemy_count: int


@export_group("Repetition")
## When targeting, applies targeting multiple times, without de-duplication - targets can be selected multiple times in different targeting passes.
@export_range(1, 1, 1, "hide_slider", "or_greater") var pass_count: int


## Returns false when using shared targeting; otherwise, returns the number of allies that should be targeted.
func get_ally_target_count():
	if !shared_count:
		return ally_count if ally_count > 0 else target_count
	return false

## Returns false when using shared targeting; otherwise, returns the number of allies that should be targeted.
func get_enemy_target_count():
	if !shared_count:
		return enemy_count if enemy_count > 0 else target_count
	return false
