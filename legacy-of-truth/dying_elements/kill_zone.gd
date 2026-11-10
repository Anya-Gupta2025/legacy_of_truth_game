extends Area2D

@onready var timer: Timer = $Timer

# Character and respawning coordinates
var dead_player: Node2D = null
@export var respawn_point: Vector2 = Vector2(179, 190)

var is_dead = false

func _on_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	is_dead = true
	
	print("You died!")
	
	# Save that the player has died
	dead_player = body
	
	# Slow down the scene when the player dies
	Engine.time_scale = 0.5
	
	# Briefly disable the collision of the player and make it fall through the shape
	dead_player.collision_layer = 0
	dead_player.collision_mask = 0
	
	# Make the player fade away
	var tween = create_tween()
	tween.tween_property(body, "modulate:a", 0.0, 0.5)
	
	# Start the timer before the scene reloads
	timer.start()
	dead_player.velocity = Vector2.ZERO

# When the timer runs, restart the scene
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	if dead_player != null:
		# Enable the collision layers and set velocity to 0
		print("reload")
		
		# Stop player's movement
		dead_player.velocity = Vector2.ZERO
		
		# Reset player to position
		dead_player.global_position = respawn_point
		
		# Resetting the fade effect
		dead_player.modulate.a = 1.0 
		
		# Make the game registers the player's new surroundings
		dead_player.force_update_transform()
		
		# Wait for the physics engine to register new position
		await get_tree().physics_frame
		
		# Reset collision layer
		dead_player.collision_layer = 2
		dead_player.collision_mask = 1
		
		# Reset the dead player to null
		dead_player = null
		
		is_dead = false
		print("Player isn't dead.")
	
	# get_tree().reload_current_scene() # Only if I want to reset scene rather than keep the coin tally too
