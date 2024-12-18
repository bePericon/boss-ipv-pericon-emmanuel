extends SkeletonBossStateBase
class_name SkeletonBossStateFollowing

func on_physics_process(_delta: float) -> void:
	if not enemy.health.is_dead_completly():
		enemy.play_animation("walk")
		if enemy.can_see_target():
			enemy.look_at_target()
			
			if enemy.is_close_target():
				enemy.stop_movement()
				state_machine.change_to(enemy.states.Attacking)
			else:
				enemy.apply_movement()
		else:
			state_machine.change_to(enemy.states.Idle)
