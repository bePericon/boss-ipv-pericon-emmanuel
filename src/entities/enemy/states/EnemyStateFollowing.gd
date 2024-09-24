extends EnemyStateBase
class_name EnemyStateFollowing

func on_physics_process(_delta: float) -> void:
	enemy.play_animation("walk")
	if enemy.can_see_target():
		enemy.look_at_target()
		enemy.setting_z_index()
		
		if enemy.is_close_target():
			enemy.stop_movement()
			state_machine.change_to(enemy.states.Idle)
		else:
			enemy.apply_movement()


func _on_enemy_hurting(amount: Variant) -> void:
	state_machine.change_to(enemy.states.Hit)
