extends Node2D

@onready var puzzle_portal: TextureButton = $puzzle_portal_animation/puzzle_portal
@onready var puzzle_portal_animation: AnimatedSprite2D = $puzzle_portal_animation
@onready var timer: Timer = $puzzle_portal_animation/Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_puzzle_portal_pressed() -> void:
	print("How to play portal enetered")
	
	# Animations
	
	# Slow down the game
	Engine.time_scale = 0.5
	
	var tween = create_tween()
	tween.tween_property(puzzle_portal, "modulate:a", 0.0, 0.5)
	
	var tween_2 = create_tween()
	tween_2.tween_property(puzzle_portal_animation, "modulate:a", 0.0, 0.5)

	
	# Start the shock timer to show that the player has died
	timer.start()


func _on_timer_timeout() -> void:

	# Reset the game speed to 1
	Engine.time_scale = 1.0
	
	# Change to level 2
	GameManager.reset_game() # Reset score
	get_tree().change_scene_to_file("res://the_tomb_level_one/level_one_the_tomb.tscn")
