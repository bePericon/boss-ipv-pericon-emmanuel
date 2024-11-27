extends Node

@export var level_manager_scene: PackedScene
@onready var select_fx: AudioStreamPlayer2D = $SelectFx
@onready var confirmation_fx: AudioStreamPlayer2D = $ConfirmationFx
@onready var play_button: Button = $Control/Panel/Control/ButtonsContainer/PlayButton
@onready var options_button: Button = $Control/Panel/Control/ButtonsContainer/OptionsButton
@onready var panel_2: Panel = $Control/Panel2
@onready var button: Button = %Button

var pressed_play:bool = false
var pressed_options:bool = false

func _on_play_button_pressed() -> void:
	pressed_play = true
	pressed_options = false
	confirmation_fx.play()

func _on_options_button_pressed() -> void:
	pressed_play = false
	pressed_options = true
	confirmation_fx.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up"):
		select_fx.play()

func _on_confirmation_fx_finished() -> void:
	if pressed_play:
		get_tree().change_scene_to_packed(level_manager_scene)
	if pressed_options:
		panel_2.show()
		button.grab_focus()

func _on_button_pressed() -> void:
	confirmation_fx.play()
	pressed_play = false
	pressed_options = false
	play_button.grab_focus()
	panel_2.hide()
