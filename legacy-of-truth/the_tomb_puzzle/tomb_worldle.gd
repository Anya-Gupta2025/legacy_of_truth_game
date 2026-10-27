extends Node2D

@onready var buttons = $GridContainer.get_children()

const SIZE = 8

var puzzle_word:String = ""
var index = 0 # Position of button text to be updated
var latest_row_index = 0
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
		if index > 0 and index > latest_row_index:
			index -= 1
			buttons[index].text = ""
			
	if Input.is_action_pressed("enter"):
		# Only check win if the entire word ahs been types out
		if row_filled:
			check_win()
			latest_row_index = index
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
		
func update_button_style(button: Button, bg_colour: Color):
	var style = button.get_theme_stylebox("normal")
	style.bg_color = bg_colour
	button.add_theme_stylebox_override("normal", style)
	

func check_win():
	# Take the text from the previous row
	var entered_text = ""
	for button in buttons.slice(latest_row_index, latest_row_index+SIZE):
		entered_text += button.text
	print("Entered Text:", entered_text)
	
	if entered_text == puzzle_word:
		print("You Win!")
		return
	
	else:
		# Update the colour of the box
		var idx = 0
		for button in buttons.slice(latest_row_index, latest_row_index+SIZE):
			if entered_text[idx] == puzzle_word[idx]:
				update_button_style(button, Color.SEA_GREEN)
			idx += 1
		
	
