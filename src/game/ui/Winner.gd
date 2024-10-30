extends Control

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var restart_button: Button = $Panel/RestartButton

signal restart_selected

func _ready() -> void:
	hide()
	GameState.connect("player_winner",  Callable(self, "_on_winner"))


func _on_winner() -> void:
	get_tree().paused = false
	restart_button.grab_focus()
	restart_button.add_theme_color_override("font_focus_color", Color("#e4d61b"))
	audio_music.play()
	show()


func _on_restart_button_pressed() -> void:
	restart_selected.emit()
