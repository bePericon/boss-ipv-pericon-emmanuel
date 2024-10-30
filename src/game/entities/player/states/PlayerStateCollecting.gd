extends PlayerStateBase
class_name PlayerStateCollenting

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start():
	player.collect_control.collected()
	audio_stream_player.play()
	state_machine.change_to(player.states.Idle)
