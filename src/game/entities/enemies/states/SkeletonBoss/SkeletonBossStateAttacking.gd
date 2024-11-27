extends SkeletonBossStateBase
class_name SkeletonBossStateAttacking

func start():
	enemy.play_animation("attack")

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		if not enemy.health.is_dead_completly():
			state_machine.change_to(enemy.states.Following)
