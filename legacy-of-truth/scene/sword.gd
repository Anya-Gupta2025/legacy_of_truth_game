extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _on_body_entered(_body):
	EventBus.sword_collected.emit()
	print("Sword 1 collected!")
	
	# Animations
	
	# Slow down the game
	Engine.time_scale = 0.5
	
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 0.5)
	
	# Start the shock timer to show that the player has died
	timer.start()

func _on_timer_timeout() -> void:

	# Reset the game speed to 1
	Engine.time_scale = 1.0
	
	# Remove the sword
	queue_free()
	
	# Change to level 2
	get_tree().change_scene_to_file("res://the_existing_level_two/level_two_the_existing.tscn")
