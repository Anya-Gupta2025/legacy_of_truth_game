extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.score_updated.connect(update_score)
	
	
@onready var score_lab: Label = $CoinTexture/ScoreLab

func update_score(score):
	score_lab.text = str(score)
	
