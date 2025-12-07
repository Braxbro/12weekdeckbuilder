@tool
extends Node

# This file exposes common values and methods as global values.
# There should be no variables in here.

## A readable list of target flags. Used to conveniently set the target mask and multi-target behaviors of a TargetBehaviorResource.
enum TargetFlags {TARGET_SELF = 2**0, TARGET_ALLIES = 2**1, TARGET_ENEMIES = 2**2, TARGET_RANDOM = 2**3, TARGET_SHARED = 2**4}

## A readable list of sides in a combat encounter. The player, by default, is on CasterSide.GOOD.
## Entities on the same CasterSide as the caster are considered 'allies'; all others are considered 'enemies'.
## Players are always the lowestmost indices on their side, if we ever make multiple possible.
enum CasterSide {GOOD, BAD}
## A readable list of places a card may be sent to when played.
## LOW_VISIBILITY immediately returns the card to the lowest-visibility portion of the deck.
## DISCARD sends the card to the discard pile, to be returned to deck later in an encounter.
## DEPLETE removes the card from an encounter, but retains it to be reinserted into the deck afterward.
## DESTROY destroys the card, removing it permanently. Suitable for temporary cards and the like.
enum CardDestination {LOW_VISIBILITY, DISCARD, DEPLETE, DESTROY}

# The following values are used for various purposes, such as determining when it is safe to replace a target count with 'all' on a card's text.
## The maximum number of entities that can exist in a scene.
const max_target_count = 2 ** 4
## The maximum number of enemies a given entity can have.
const max_enemy_count = max_target_count / 2
## The maximum number of allies a given entity can have.
const max_ally_count = max_enemy_count - 1
