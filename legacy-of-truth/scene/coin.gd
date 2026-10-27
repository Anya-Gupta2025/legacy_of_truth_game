extends Area2D



func _on_body_entered(body):
	EventBus.coin_collected.emit()
	print("+1 coin!")
	queue_free()
	
	
