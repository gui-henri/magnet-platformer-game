extends Sprite

func _on_player_body_entered(_body):
	if _body.name == "Player":
		queue_free()
