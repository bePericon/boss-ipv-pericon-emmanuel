extends Area2D

@onready var initial_limit: StaticBody2D = $InitialLimit
@onready var end_limit: StaticBody2D = $EndLimit

signal initial_position(x: float)

func _on_body_entered(body: Node2D) -> void:
	print("globla: ", body.global_position.x, " position: ",body.global_position.x)
	if body.name == "Player" and body.global_position.x >= position.x:
		initial_limit.collision_layer = 8
		initial_position.emit(position.x)
