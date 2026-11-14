extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_respawning: bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var y_limit: float = 1000.0
var respawn_point: Vector2


func _ready() -> void:
	# Save exact starting position
	respawn_point = global_position
	# Trigger death 250 pixels below the starting platform
	y_limit = 680.0

	# Lock camera so screen never jumps up and down
	if has_node("Camera2D"):
		$Camera2D.limit_top = int(respawn_point.y - 450)
		$Camera2D.limit_bottom = int(respawn_point.y + 200)
		$Camera2D.drag_vertical_enabled = false


func _physics_process(delta: float) -> void:
	if is_respawning:
		return

	# Check if player has fallen into a pit
	if global_position.y > y_limit:
		respawn()
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (Input.is_action_just_pressed("Spacebar") or Input.is_action_just_pressed("ui_up") or Input .is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Move left / right
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		sprite.play("idle_right")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")

	move_and_slide()


func respawn() -> void:
	if is_respawning:
		return
	
	is_respawning = true
	velocity = Vector2.ZERO
	Engine.time_scale = 0.5

	# Fade out and wait for it to finish (ignores slow motion)
	var tween = create_tween()
	tween.set_ignore_time_scale(true)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
	await tween.finished

	# Bring player back to start immediately
	Engine.time_scale = 1.0
	velocity = Vector2.ZERO
	global_position = respawn_point
	sprite.modulate.a = 1.0
	is_respawning = false
