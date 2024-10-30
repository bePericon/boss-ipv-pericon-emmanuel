extends PlayerStateBase
class_name PlayerStateHit

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start():
	player.play_animation("hit")
	audio_stream_player.play()

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		if not player.health.is_dead_completly():
			state_machine.change_to(player.states.Idle)
		else:
			state_machine.change_to(player.states.Dead)
