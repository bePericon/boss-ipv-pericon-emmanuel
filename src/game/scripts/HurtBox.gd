extends Area2D
class_name HurtBox

@export var layer:int = 1
@export var mask:int = 1

func _ready() -> void:
	collision_layer = layer
	collision_mask = mask
	#self.connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox == null:
		return
	
	if hitbox is HitBox and owner.has_method("take_damage") and assert_hit(hitbox):
		owner.take_damage(hitbox.damage)


func assert_hit(hitbox: Area2D) -> bool:
	return  (owner.global_position.y - hitbox.global_position.y) < 10
