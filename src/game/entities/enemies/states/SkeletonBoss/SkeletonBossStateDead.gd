extends SkeletonBossStateBase
class_name SkeletonBossStateDead

func start():
	enemy.play_animation("dead")
	enemy.collision_layer = 0
	enemy.collision_mask = 0

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		enemy.remove()
