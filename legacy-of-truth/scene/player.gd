extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer_2: Timer = $Timer2

var is_respawning: bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var y_limit: float = 600.0 
@export var respawn_point: Vector2 = Vector2(179, 190)

func _physics_process(delta: float) -> void:
	# Check Y limit only if not currently respawning
	if global_position.y > y_limit and not is_respawning:
		respawn()

	# Stop player movement while waiting to respawn
	if is_respawning:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	#Stop moving
		velocity.x = move_toward(velocity.x, 0, SPEED)

#Play idle animation
		sprite.play("idle")
	
	move_and_slide()
	
func respawn() -> void:
	is_respawning = true
	velocity = Vector2.ZERO
	Engine.time_scale = 0.5
	timer_2.start()

func _on_timer_2_timeout() -> void:
	# Reset game speed back to normal 1.0 scale
	Engine.time_scale = 1.0
	
	global_position = respawn_point
	is_respawning = false
	
	
		
