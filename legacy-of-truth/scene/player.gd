
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer_2: Timer = $Timer2

var is_respawning: bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var y_limit: float = 600.0
@export var respawn_point: Vector2 = Vector2(179, 190)


func _physics_process(delta: float) -> void:

	# Stop all movement while player is coming back to life
	if is_respawning:
		return

	# Check if player has fallen below the boundary
	if global_position.y > y_limit:
		respawn()
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement side to side
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		
		#Flip the animation
		if direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		
		#Play run animation
		sprite.play("idle_right")
		
	else:
		# Stop moving
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Play idle animation
		sprite.play("idle")

	# Enable movement
	move_and_slide()


func respawn() -> void:
	if is_respawning:
		return
	
	# Make sure the player doesn't loop on respawning
	is_respawning = true
	
	# Stop the player
	velocity = Vector2.ZERO 

	# Slow down the game
	Engine.time_scale = 0.5 

	# Add fade effect
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5) 
	
	# Start the shock timer to show that the player has died
	timer_2.start()


func _on_timer_2_timeout() -> void:

	# Reset the game speed to 1
	Engine.time_scale = 1.0

	# Stop player movement
	velocity = Vector2.ZERO

	# Teleport to spawn
	global_position = respawn_point

	# Fix the visibility
	sprite.modulate.a = 1.0

	# Allow the player to move again
	is_respawning = false
