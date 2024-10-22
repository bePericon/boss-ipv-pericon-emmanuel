extends Area2D
class_name Reward

@export var collectible_type:String

var is_collected:bool = false

func _on_body_entered(body: Node2D) -> void:
	if not is_collected:
		is_collected = true
		body.collect_control.for_collect(self)

func collected():
	get_tree().call_group("CollectControl", "on_collected", collectible_type)
	print("Collected reward type: ", collectible_type)
	queue_free()

func _on_body_exited(body: Node2D) -> void:
	is_collected = false
	body.collect_control.clear_for_collect()
