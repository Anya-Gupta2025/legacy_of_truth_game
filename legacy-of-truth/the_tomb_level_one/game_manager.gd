extends Node

var score = 0

func increase_score():
	EventBus.score_updated.emit(score)
	score+=1
	print(score)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.coin_collected.connect(increase_score)
	pass # Replace with function body.
