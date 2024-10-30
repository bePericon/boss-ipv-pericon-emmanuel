extends Control

@onready var audio_music: AudioStreamPlayer = $AudioMusic


func _ready() -> void:
	hide()
	GameState.connect("current_player_changed",  Callable(self, "_on_current_player_changed"))


func _on_current_player_changed(player: Player) -> void:
	player.health.connect("dead_completly", Callable(self,"_on_dead_completly"))
	_on_dead_completly(player)


func _on_dead_completly(player: Player) -> void:
	if player.health.is_dead_completly():
		audio_music.play()
		show()
