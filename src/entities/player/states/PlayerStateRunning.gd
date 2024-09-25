extends PlayerStateBase
class_name PlayerStateRunning

func on_physics_process(_delta: float) -> void:
	player.play_animation("run")
	
	#Horizontal Movement
	player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.ACCELERATION
	if Input.get_axis("ui_left", "ui_right") != 0:
		player.flip_direction()
	
	#Vertical Movement
	player.velocity.y = Input.get_axis("ui_up", "ui_down") * player.ACCELERATION

	player.move_and_slide()
	
func on_input(_event: InputEvent) -> void:
	var is_right_pressed = Input.is_action_pressed("ui_right")
	var is_left_pressed = Input.is_action_pressed("ui_left")
	var is_down_pressed = Input.is_action_pressed("ui_down")
	var is_up_pressed = Input.is_action_pressed("ui_up")
	
	if not is_left_pressed and not is_right_pressed and not is_up_pressed and not is_down_pressed: 
		state_machine.change_to(player.states.Idle)
