extends Node2D

@onready var buttons = $GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_button_styles()
	reset_game()

func reset_game():
	for button in buttons:
		var b = button as Button
		b.text = ""

func init_button_styles():
	for button in buttons:
		var b = button as Button
		var style = StyleBoxFlat.new()
		style.bg_color = Color.BLACK
		style.border_color = Color.DIM_GRAY
		style.border_width_bottom = 2
		style.border_width_top = 2
		style.border_width_right = 2
		style.border_width_left = 2
		b.add_theme_stylebox_override("normal", style)	
		
