extends Node
class_name GameLevel

@onready var audio_music: AudioStreamPlayer = $AudioMusic

# Regresa al menu principal
signal return_requested()
# Reinicia el nivel
signal restart_requested()
# Inicia el siguiente nivel
signal next_level_requested()


func _ready() -> void:
	randomize()


# Funciones que hacen de interfaz para las señales
func _on_level_won() -> void:
	emit_signal("next_level_requested")


func _on_return_requested() -> void:
	emit_signal("return_requested")


func _on_restart_requested() -> void:
	emit_signal("restart_requested")


func _on_finish_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if audio_music:
			audio_music.stop()
		GameState.winner()

func _on_player_death() -> void:
	if audio_music:
		audio_music.stop()

func slow_music() -> void:
	audio_music.pitch_scale = 0.8

func fast_music() -> void:
	audio_music.pitch_scale = 1
