extends CanvasLayer

# References to our nodes
@onready var hamburger_btn = $"Hamburger Btn"
@onready var menu_over = $MenuOverlay2

func _ready():
	# Start with ONLY the 3 lines visible in the center
	hamburger_btn.visible = true
	menu_over.visible = false

# --- BUTTON ACTIONS ---

# This runs when you click the 3 lines in the center
func _on_hamburger():
	# Hide the 3 lines completely
	hamburger_btn.visible = false
	# Show the Start, Pause, and Quit screen in the middle
	menu_over.visible = true

# This runs when you click your Start button
func _on_start():
	menu_over.visible = false
	# Bring back the 3 lines in case they pause later
	hamburger_btn.visible = true
	get_tree().paused = false

# This runs when you click your Pause button
func _on_pause():
	get_tree().paused = true
	menu_over.visible = false
	hamburger_btn.visible = true

# This handles closing down the game safely
func _on_quit():
	get_tree().quit()
