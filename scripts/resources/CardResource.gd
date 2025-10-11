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
@export var effects: Array[EffectResource]

## Trigger the card's effects.
func play_effects():
	var target_batch = BatchTargetCache.new()
	for effect in effects:
		if effect is TargetedEffectResource:
			# Since EffectResource's invoke_effect function accepts no args, this is needed to tell Godot that the card is actually a TargetedEffectResource.
			(effect as TargetedEffectResource).invoke_effect(target_batch)
		else:
			effect.invoke_effect()
