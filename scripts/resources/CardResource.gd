class_name CardResource extends Resource

@export_group("Card Properties")
## Will be localized if possible - strings with no matching locale keys will be treated as literal.
@export var cardName: String
## Optional image to display on the card.
@export var thumbnailArt: Texture2D
## Whether the card should use a full-art layout. Does nothing if thumbnailArt is unset.
@export var fullArt: bool

@export_group("Card Effects")
## A list of effects that the card has.
@export var effects: Array[CardEffectResource]

## Trigger the card's effects, targeting ally_target or enemy_target as applicable.
func trigger_effects(ally_target, enemy_target):
	pass
