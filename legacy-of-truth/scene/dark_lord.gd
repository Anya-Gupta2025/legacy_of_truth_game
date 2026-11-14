extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 40.0          # Slower walking speed
@export var move_distance: float = 80.0  # Distance to walk left and right
@export var pause_time: float = 1.5      # Seconds to wait at each side

var start_x: float
var direction: int = 1  # 1 = right, -1 = left
var is_waiting: bool = false


func _ready() -> void:
	start_x = position.x
	sprite.play("walk")


func _process(delta: float) -> void:
	# Stop moving while pausing at the left or right edge
	if is_waiting:
		return

	# Move left or right
	position.x += direction * speed * delta

	# Pause and turn around at the right limit
	if direction == 1 and position.x >= start_x + move_distance:
		position.x = start_x + move_distance
		wait_and_turn(-1, true)
	# Pause and turn around at the left limit
	elif direction == -1 and position.x <= start_x - move_distance:
		position.x = start_x - move_distance
		wait_and_turn(1, false)


func wait_and_turn(new_direction: int, flip: bool) -> void:
	is_waiting = true
	await get_tree().create_timer(pause_time).timeout
	direction = new_direction
	sprite.flip_h = flip
	is_waiting = false
