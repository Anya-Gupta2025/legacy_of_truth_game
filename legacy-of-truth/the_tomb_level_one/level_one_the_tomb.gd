extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Level loaded") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_puzzle_portal_pressed() -> void:
	get_tree().change_scene_to_file("res://the_tomb_puzzle/tomb_puzzle_one.tscn")
