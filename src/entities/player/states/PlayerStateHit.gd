extends PlayerStateBase
class_name PlayerStateHit

func start():
	player.play_animation("hit")


func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		if not player.health.is_dead():
			state_machine.change_to(player.states.Idle)
		else:
			state_machine.change_to(player.states.Dead)
