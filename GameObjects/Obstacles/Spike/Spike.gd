extends Node2D

func _on_player_body_entered(_body):
	if _body.name == "Player":
		get_tree().reload_current_scene()
