extends EnemyStateBase
class_name EnemyStateHit

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start():
	enemy.play_animation("hit")
	audio_stream_player.play()


func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		if not enemy.health.is_dead_completly():
			state_machine.change_to(enemy.states.Idle)
		else:
			state_machine.change_to(enemy.states.Dead)
