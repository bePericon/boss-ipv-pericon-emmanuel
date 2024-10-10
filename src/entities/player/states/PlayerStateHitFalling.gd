extends PlayerStateBase
class_name PlayerStateHitFalling

signal ending

func on_physics_process(delta):
	player.play_animation("hit")
	
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.ACCELERATION
	
	if player_on_initial_floor():
		state_machine.change_to(player.states.Idle)
	else:
		handle_gravity(delta)
	
	player.move_and_slide()

func end():
	player.jump_control.y = 0
	player.velocity.y = 0
	ending.emit()

func handle_gravity(delta):
	var gravity = player.get_gravity() * delta
	player.velocity.y = gravity.y * 10

func player_on_initial_floor() -> bool:
	return player.jump_control.y - player.global_position.y <= 0
