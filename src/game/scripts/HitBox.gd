extends Area2D
class_name HitBox

@export var damage:int 
@export var layer:int
@export var mask:int

func _ready() -> void:
	collision_layer = layer
	collision_mask = mask
