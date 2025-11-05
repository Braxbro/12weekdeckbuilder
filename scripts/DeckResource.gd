extends Node
inherits LightLevel.gd
# ---------------------------
# CARD MANAGEMENT
# ---------------------------

func add_card_to_deck(card) -> void:
	deck.append(card)
	_insert_at_lowest_visibility(card)


func _insert_at_lowest_visibility(card) -> void:
	var pos = rng.randi_range(0, deck.size() - 1)
	card_vis_levels[card] = 0 # lowest visibility
	deck.insert(pos, card)


func decay_visibility() -> void:
	# Called over time, reduces visibility stage of all cards
	for card in deck:
		if card_vis_levels.has(card):
			card_vis_levels[card] = max(0, card_vis_levels[card] - 1)


func refresh_visible_cards() -> void:
	visible_cards.clear()
	var target_count = get_visible_card_count()
	# Show cards with highest visibility first
	var sorted_cards = deck.duplicate()
	##sorted_cards.sort_custom(self, "_sort_by_visibility")

	for i in range(min(target_count, sorted_cards.size())):
		visible_cards.append(sorted_cards[i])


func _sort_by_visibility(a, b) -> int:
	return card_vis_levels.get(b, 0) - card_vis_levels.get(a, 0)
