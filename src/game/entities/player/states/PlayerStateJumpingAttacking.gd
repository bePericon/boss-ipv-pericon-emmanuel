extends PlayerStateBase
class_name PlayerStateJumpingAttacking

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start():
	player.play_animation("attack_01")
	audio_stream_player.play()

func on_physics_process(_delta):
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.ACCELERATION
	
	if player_on_floor() and player.velocity.y >= 0:
		player.velocity.y = -player.JUMP_VELOCITY
	
	player.move_and_slide()

func player_on_floor() -> bool:
	return player.global_position.y < 196 and player.global_position.y > 104

func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_01" and state_machine:
		if state_machine.current_state.name == player.states.JumpingAttacking:
			state_machine.change_to(player.states.Falling)
 
