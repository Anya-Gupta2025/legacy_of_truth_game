extends Node

var score = 0
var sword_pieces = 1

func increase_score():
	score += 1
	EventBus.score_updated.emit(score)
	print(score)
	
func increase_sword():
	sword_pieces += 1
	EventBus.sword_updated.emit(sword_pieces)
	print(sword_pieces)
	
func reset_game():
	score = 0
	sword_pieces = 0
	
	EventBus.score_updated.emit(score)
	EventBus.sword_updated.emit(sword_pieces)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.coin_collected.connect(increase_score)
	EventBus.sword_collected.connect(increase_sword)
