extends Node

# This file should ONLY contain connections between major features to make routing events cleaner and more flexible.
# Direct parent-to-child relations, like a deck communicating with a card, should not go through this.

# For example, the deck handler asking the timeline to schedule something would be a good use for this file.
