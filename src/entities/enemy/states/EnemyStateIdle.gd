extends EnemyStateBase
class_name EnemyStateIdle

func start():
	enemy.play_animation("idle")


func _on_enemy_hurting(_amount: Variant) -> void:
	state_machine.change_to("EnemyStateHit")
