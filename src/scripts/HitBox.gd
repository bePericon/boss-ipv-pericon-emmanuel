extends Area2D
class_name HitBox

@export var damage: int = 10

func _init() -> void:
	collision_layer = 5
	collision_mask = 0
