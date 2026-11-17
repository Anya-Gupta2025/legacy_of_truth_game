extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Level 2 loaded")
	
	# Save the score at teh start of level 2
	GameManager.save_level_2_checkpoint()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_puzzle_portal_pressed() -> void:
	print("Portal pressed")
	get_tree().change_scene_to_file("res://the_existing_puzzle/existing_puzzle_one.tscn")
