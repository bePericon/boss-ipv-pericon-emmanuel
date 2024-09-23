extends StaticBody2D


func _on_player_player_jumping(is_running: bool) -> void:
	set_collision_layer_value(7, !is_running)
