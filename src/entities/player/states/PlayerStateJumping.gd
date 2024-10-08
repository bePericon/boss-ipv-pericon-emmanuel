extends PlayerStateBase
class_name PlayerStateJumping

signal running()

func start():
	running.emit()
	player.jump_control.y = player.global_position.y

func on_physics_process(_delta):
	player.play_animation("jump")
	
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.ACCELERATION
	
	if player_on_floor() and player.velocity.y >= 0:
		player.velocity.y = -player.JUMP_VELOCITY
	elif player_on_top() :
		state_machine.change_to(player.states.Falling)
	
	player.move_and_slide()

func player_on_top() -> bool:
	return player.jump_control.y - player.global_position.y > 100

func player_on_floor() -> bool:
	return player.global_position.y < 196 and player.global_position.y > 104
