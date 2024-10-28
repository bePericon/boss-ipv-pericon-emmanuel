extends PlayerStateBase
class_name PlayerStateAttacking

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start():
	player.play_animation("attack_01")
	audio_stream_player.play()

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_01" and state_machine:
		if state_machine.current_state.name == player.states.Attacking:
			state_machine.change_to(player.states.Idle)
