extends PlayerStateBase
class_name PlayerStateCollenting

func start():
	player.collect_control.collected()
	state_machine.change_to("PlayerStateIdle")
