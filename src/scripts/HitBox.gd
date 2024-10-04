extends Area2D
class_name HitBox

@export var damage:int = 1
@export var layer:int = 1
@export var mask:int = 1

func _ready() -> void:
	collision_layer = layer
	collision_mask = mask
