extends Node2D

@onready var monster1: Node2D = $Monsters
@onready var monster2: Node2D = $Monsters2
@onready var monster3: Node2D = $Monsters3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_monsters()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_monsters():
	if GameManager.score >= 10:
		monster1.queue_free()
		
	if GameManager.score >= 20:
		monster2.queue_free()

	if GameManager.score >= 25:
		monster3.queue_free()
