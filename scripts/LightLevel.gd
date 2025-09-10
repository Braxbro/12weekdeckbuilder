extends Node
class_name LightLevel

#Configurable properties
var max_light_level: int = 10
var light_level: int = 5
var light_colors: Array = ["white", 
	"red", 
	"blue", 
	"green", 
	"yellow",
	#Add New Element here if needed.
	]

#Visibilty
var base_visible_cards: int = 1 #Minimum visible at level 1
var base_decay_rate: float = 1.0  # seconds before visibility decreases

# Scaling multipliers
var difficulty_scale: float = 1.0
var reward_scale: float = 1.0

# Card deck storage
var deck: Array = []     # full deck of cards
var visible_cards: Array = [] # currently visible cards
var card_vis_levels: Dictionary = {} # card -> visibility stage
var rng := RandomNumberGenerator.new()

# Optional: Current light color
var current_light_color: String = "white"


func _ready():
	rng.randomize()

# ---------------------------
# LIGHT LEVEL MANAGEMENT
# ---------------------------

func set_light_level(level: int) -> void:
	light_level = clamp(level, 1, max_light_level)
	_recalculate_scales()


func _recalculate_scales() -> void:
	# More light = easier difficulty, less reward
	difficulty_scale = 1.0 - float(light_level) / float(max_light_level) * 0.5
	reward_scale = 1.0 - difficulty_scale


func get_visible_card_count() -> int:
	# More light = more visible cards
	return base_visible_cards + int(light_level / 2)


func get_decay_rate() -> float:
	# Higher light slows decay
	return base_decay_rate + (float(light_level) / float(max_light_level)) * 2.0

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

# ---------------------------
# LIGHT COLOR EXPANSION
# ---------------------------

func get_card_information(card) -> Dictionary:
	var info: Dictionary = {}
	var base_visibility = card_vis_levels.get(card, 0)

	# If colors match, grant extra info
	if card.has("effect_color"):
		if card.effect_color == current_light_color:
			info["detail_level"] = base_visibility + 2
		else:
			info["detail_level"] = max(0, base_visibility - 1)
	else:
		info["detail_level"] = base_visibility

	return info
