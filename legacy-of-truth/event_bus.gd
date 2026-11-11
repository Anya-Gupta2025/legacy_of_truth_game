extends Node

signal coin_collected
signal score_updated(score)

signal sword_collected
signal sword_updated(sword_pieces)

var score: int = 0
var sword_pieces: int = 1

func _ready() -> void:
	coin_collected.connect(_on_coin_collected)
	sword_collected.connect(_on_sword_collected)

func _on_coin_collected() -> void:
	score += 1
	score_updated.emit(score)

func _on_sword_collected() -> void:
	sword_pieces += 1
	sword_updated.emit(sword_pieces)
