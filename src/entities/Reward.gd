extends Area2D
class_name Reward

@export var collectible_type:String

var is_collected:bool = false

signal on_collected

func _on_body_entered(body: Node2D) -> void:
	print("Reward contact to: ", body.name)
	print("Reward type: ", collectible_type)
	if not is_collected:
		is_collected = true
		body.collecting(self)


func collected():
	emit_signal("on_collected", collectible_type)
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	print("Reward _on_body_exited : ", body.name)
	print("Reward type: ", collectible_type)
	is_collected = false
	body.uncollecting()
