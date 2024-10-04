extends EnemyStateBase
class_name EnemyStateIdle

@onready var idle_timer: Timer = $IdleTimer

func start():
	enemy.play_animation("idle")
	if not enemy.health.is_dead():
		idle_timer.start()
	#else:
		#state_machine.change_to("EnemyStateDead")


func _on_enemy_hurting(_amount: Variant) -> void:
	state_machine.change_to(enemy.states.Hit)


func _on_enemy_found() -> void:
	state_machine.change_to(enemy.states.Following)


func _on_idle_timer_timeout() -> void:
	state_machine.change_to(enemy.states.Following)

func _on_health_dead() -> void:
	state_machine.change_to(enemy.states.Dead)
