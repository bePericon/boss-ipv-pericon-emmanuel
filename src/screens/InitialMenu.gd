extends Node

@export var level_manager_scene: PackedScene
@onready var select_fx: AudioStreamPlayer2D = $SelectFx
@onready var confirmation_fx: AudioStreamPlayer2D = $ConfirmationFx


func _ready() -> void:
	select_fx.stream = preload("res://assets/sounds/fx/select_001.ogg")
	confirmation_fx.stream = preload("res://assets/sounds/fx/confirmation_003.ogg")

func _on_play_button_pressed() -> void:
	confirmation_fx.play()


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up"):
		select_fx.play()


func _on_confirmation_fx_finished() -> void:
	get_tree().change_scene_to_packed(level_manager_scene)
