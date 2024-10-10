extends PlayerStateBase
class_name PlayerStateIdle

func start():
	player.play_animation("idle")

func on_physics_process(_delta: float) -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.move_and_slide()
	
func on_input(_event: InputEvent) -> void:
	var is_right_pressed = Input.is_action_pressed("ui_right")
	var is_left_pressed = Input.is_action_pressed("ui_left")
	var is_down_pressed = Input.is_action_pressed("ui_down")
	var is_up_pressed = Input.is_action_pressed("ui_up")
	
	if is_right_pressed or is_left_pressed or is_down_pressed or is_up_pressed:
		state_machine.change_to(player.states.Running)
	elif Input.is_action_just_pressed("attack_01"):
		if player.collect_control.exist_object():
			state_machine.change_to(player.states.Collecting)
		else:
			state_machine.change_to(player.states.Attacking)
	elif Input.is_action_just_pressed("jump"):  
		state_machine.change_to(player.states.Jumping)


func _on_player_hurting(amount: Variant) -> void:
	if state_machine.current_state.name == player.states.Idle:
		state_machine.change_to(player.states.Hit)


func _on_health_dead() -> void:
	state_machine.change_to(player.states.Dead)
