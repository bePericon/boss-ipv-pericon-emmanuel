extends Camera2D

signal close_initial_limit

func _on_fight_zone_area_entered(area: Area2D) -> void:
	if area.name == "AlertFightZone":
		limit_left = 160
		limit_right = 160 + 320
		close_initial_limit.emit()
