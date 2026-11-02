extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	
	# Slow down the scene when the player dies
	Engine.time_scale = 0.5
	
	# Remove the collision of the player and make it fall through the shape
	body.get_node("CollisionShape2D").queue_free()
	
	# Make the player fade away
	var tween = create_tween()
	tween.tween_property(body, "modulate:a", 0.0, 0.5)
	
	# Start the timer before the scene reloads
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
