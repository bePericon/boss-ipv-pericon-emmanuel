extends Node2D

@onready var fight_zone: Area2D = $FightZone
@onready var initial_limit: StaticBody2D = $FightZone/InitialLimit
@onready var end_limit: StaticBody2D = $FightZone/EndLimit

signal initial_position(x: float)

func _on_camera_2d_close_initial_limit() -> void:
	initial_limit.collision_layer = 8


func _on_fight_zone_area_entered(area: Area2D) -> void:
	print("Area name: ", area.name)
	if area.name == "AlertFightZone":
		initial_limit.collision_layer = 8
