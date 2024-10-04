extends PlayerStateBase
class_name PlayerStateDead

func start():
	player.play_animation("dead")
	player.collision_layer = 0
	player.collision_mask = 0

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		if player.health.can_revive():
			player.health.revive()
			state_machine.change_to(player.states.Idle)
		else:
			player.remove()
