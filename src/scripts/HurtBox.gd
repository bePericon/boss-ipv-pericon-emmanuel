extends Area2D
class_name HurtBox

func _init() -> void:
	collision_layer = 0
	collision_mask = 5


func _ready() -> void:
	self.connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox == null:
		return
	
	if hitbox is HitBox and owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
