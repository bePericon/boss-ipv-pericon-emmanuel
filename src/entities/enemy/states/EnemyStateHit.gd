extends EnemyStateBase
class_name EnemyStateHit

func start():
	enemy.play_animation("hit")


func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		if not enemy.health.is_dead():
			state_machine.change_to(enemy.states.Idle)
		else:
			state_machine.change_to(enemy.states.Dead)
