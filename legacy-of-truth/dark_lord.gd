extends CharacterBody2D

@export var speed: float = 100.0
@export var patrol_distance: float = 75.0 # How far to walk before turning around
@onready var timer: Timer = $Timer
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var start_x: float
var direction: int = 1 # 1 = moving right, -1 = moving left

func _ready() -> void:
	start_x = position.x

func _physics_process(_delta: float) -> void:
	# Move automatically
	velocity.x = direction * speed
	move_and_slide()

	# Turn around when reaching the right or left limit
	if position.x >= start_x + patrol_distance:
		direction = -1
	elif position.x <= start_x - patrol_distance:
		direction = 1

	# Play the matching sword-walking animation
	if direction > 0:
		anim.play("walk_right")
	else:
		anim.play("walk_left")

func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://win_screen.tscn")
