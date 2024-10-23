extends Node

@export var level_manager_scene: PackedScene

func _ready() -> void:
	pass

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_manager_scene)


func _on_options_button_pressed() -> void:
	pass # Replace with function body.
