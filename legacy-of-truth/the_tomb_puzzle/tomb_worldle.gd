extends Node2D

@onready var buttons = $GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_game()

func reset_game():
	for button in buttons:
		var b = button as Button
		b.text = ""
		
