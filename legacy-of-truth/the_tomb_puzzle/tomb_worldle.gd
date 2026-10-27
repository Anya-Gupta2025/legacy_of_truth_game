extends Node2D

@onready var buttons = $GridContainer.get_children()

var puzzle_word:String = ""
var index = 0 # Position of button text to be updated
var row_filled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_button_styles()
	reset_game()
	
func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode >= KEY_A and event.keycode <= KEY_Z:
			var letter = char(event.keycode)
			print("Letter: ", letter)
			
			# Only update until entire row is filled.
			if not row_filled:
				buttons[index].text = letter
				index += 1
				
				if index != 0 and index % 8 == 0:
					row_filled = true
			
	if Input.is_action_pressed("back"):
		if index > 0:
			index -= 1
			buttons[index].text = ""
			
	if Input.is_action_pressed("enter"):
		# Only check win if the entire word ahs been types out
		if row_filled:
			check_win()
			row_filled = false

func reset_game():
	puzzle_word = "RESEARCH"
	print("Word: ", puzzle_word)
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
		
func check_win():
	pass
	
