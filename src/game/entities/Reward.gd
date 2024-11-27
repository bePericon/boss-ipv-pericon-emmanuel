extends Area2D
class_name Reward

@export var collectible_type:String
@onready var flash_sprite: Sprite2D = $FlashSprite

var is_collected:bool = false

func _physics_process(_delta: float) -> void:
	flash_sprite.visible = is_collected

func _on_body_entered(body: Node2D) -> void:
	if not is_collected and body.name == "Player":
		is_collected = true
		body.collect_control.for_collect(self)

func collected():
	get_tree().call_group("CollectControl", "on_collected", collectible_type)
	print("Collected reward type: ", collectible_type)
	queue_free()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_collected = false
		body.collect_control.clear_for_collect()
