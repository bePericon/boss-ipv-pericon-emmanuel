extends PlayerStateBase
class_name PlayerStateJumping

signal running()

func start():
	running.emit()
	player.jump_control.y = player.global_position.y
	player.last_shadow_position = player.feet_shape.global_position

func on_physics_process(_delta):
	player.play_animation("jump")
	
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.ACCELERATION
	if Input.get_axis("ui_left", "ui_right") != 0:
		player.flip_direction()
	
	if Input.is_action_just_pressed("attack_01"):
		state_machine.change_to(player.states.JumpingAttacking)
	
	if player_on_floor() and player.velocity.y >= 0:
		player.velocity.y = -player.JUMP_VELOCITY
	elif player_on_top() :
		state_machine.change_to(player.states.Falling)
	
	player.move_and_slide()

func player_on_top() -> bool:
	return player.jump_control.y - player.global_position.y > 100

func player_on_floor() -> bool:
	return player.global_position.y < 196 and player.global_position.y > 104


func _on_player_hurting(_amount: Variant) -> void:
	if state_machine:
		if state_machine.current_state.name == player.states.Jumping:
			state_machine.change_to(player.states.HitFalling)
