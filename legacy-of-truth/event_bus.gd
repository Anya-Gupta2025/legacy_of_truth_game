extends Node

signal coin_collected
signal score_updated(score)

var score: int = 0

func _ready() -> void:
	coin_collected.connect(_on_coin_collected)

func _on_coin_collected() -> void:
	score += 1
	score_updated.emit(score)
