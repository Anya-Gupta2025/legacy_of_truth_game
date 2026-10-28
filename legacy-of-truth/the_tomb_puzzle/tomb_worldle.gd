extends Node2D

@onready var buttons = $GridContainer.get_children()
@onready var result_layer = $result_layer
@onready var continue_button = $result_layer/continue_button
@onready var lose_button = $result_layer/lose_button
@onready var label = $result_layer/result_label
@onready var lose_label = $result_layer/lose_label

const SIZE = 8

var puzzle_word:String = ""
var index = 0 # Position of button text to be updated
var latest_row_index = 0
var row_filled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	index = 0
	row_filled = false
	latest_row_index = 0
	result_layer.hide()
	puzzle_word = "RESEARCH"
	print("Word: ", puzzle_word)
	for button in buttons:
		init_button_styles(button)

func init_button_styles(b: Button):
	b.text = ""
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
	
	# Change the colour of each text tile
	var idx = 0
	for button in buttons.slice(latest_row_index, latest_row_index+SIZE):

		if entered_text[idx] == puzzle_word[idx]:
			update_button_style(button, Color.SEA_GREEN)
			
		elif entered_text[idx] in puzzle_word:
			update_button_style(button, Color.CHOCOLATE)
			
		elif entered_text[idx] not in puzzle_word:
			update_button_style(button, Color.CRIMSON)
			
		idx += 1
	
	# Check if player won
	if entered_text == puzzle_word:
		result_layer.show()
		label.text = "You suceeded!"
		lose_button.hide()
		lose_label.hide()
		
	# Check lose condition when all attempts are up
	if index == buttons.size():
		result_layer.show()
		label.text = "You couldn't suceed!"
		continue_button.hide()
		
		
