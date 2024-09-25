extends PlayerStateBase
class_name PlayerStateAttacking

func start():
	if not player.collect_control.exist_object():
		player.play_animation("attack_01")
		#player.attack()


func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_01":
		state_machine.change_to(player.states.Idle)
