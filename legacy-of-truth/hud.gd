extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.score_updated.connect(update_score)
	EventBus.sword_updated.connect(update_sword)
	
@onready var sword_label: Label = $sword_texture/sword_label
@onready var score_lab: Label = $CoinTexture/ScoreLab

func update_score(score):
	score_lab.text = str(score)
	print(score)
	
func update_sword(sword_pieces):
	sword_label.text = str(" = ", sword_pieces, " Pieces")
	print(sword_pieces)
	
