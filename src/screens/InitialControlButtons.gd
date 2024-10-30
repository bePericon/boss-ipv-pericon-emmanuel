extends Node

@onready var play_button: Button = $ButtonsContainer/PlayButton
@onready var options_button: Button = $ButtonsContainer/OptionsButton
@onready var play_selector: Sprite2D = $ButtonsContainer/PlaySelector
@onready var options_selector: Sprite2D = $ButtonsContainer/OptionsSelector

func _ready() -> void:
	play_button.grab_focus()
	play_selector.show()
	options_selector.hide()

func _physics_process(delta: float) -> void:
	if play_button and not play_button.has_focus():
		play_selector.hide()
		options_selector.show()
		options_button.add_theme_color_override("font_focus_color", Color("#e4d61b"))
	
	if options_button and not options_button.has_focus():
		options_selector.hide()
		play_selector.show()
		play_button.add_theme_color_override("font_focus_color", Color("#e4d61b"))


func _on_play_button_pressed() -> void:
	play_button.disabled = true
