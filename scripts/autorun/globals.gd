extends Node

# This file exposes common values and methods as global values.
# There should be no variables in here.
<<<<<<< Updated upstream
=======

## A readable list of target flags. Used to conveniently set the target mask and multi-target behaviors of a TargetBehaviorResource.
enum TargetFlags {TARGET_SELF = 2**0, TARGET_ALLIES = 2**1, TARGET_ENEMIES = 2**2, TARGET_RANDOM = 2**3, TARGET_SHARED = 2**4}

# The following values are used for various purposes, such as determining when it is safe to replace a target count with 'all' on a card's text.
## The maximum number of entities that can exist in a scene.
const max_target_count = 2 ** 4
## The maximum number of enemies a given entity can have.
const max_enemy_count = max_target_count / 2
## The maximum number of allies a given entity can have.
const max_ally_count = max_enemy_count - 1
>>>>>>> Stashed changes
