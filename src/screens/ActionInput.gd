@tool
extends Node

@onready var input: Button = %Input
@onready var action: Label = %Action

@export var action_id:String
#:
	#set (value):
		#_set_action_id(value)
@export var action_name:String
#:
	#set (value):
		#_set_action_name(value)

func _ready() -> void:
	set_process_input(false)
	input.text = "  " + action_id + "  "
	action.text = action_name
	if !Engine.is_editor_hint() && InputMap.has_action(action_id):
		var event: InputEvent = InputMap.action_get_events(action_id)[0]
		_set_event(event)

func _input(event: InputEvent) -> void:
	if !event is InputEventMouseMotion:
		InputMap.action_erase_events(action_id)
		InputMap.action_add_event(action_id, event)
		_set_event(event)
		set_process_input(false)
		await get_tree().create_timer(0.1).timeout
		input.grab_focus()

func _set_event(event: InputEvent) -> void:
	input.text = event.as_text()

#func _set_action_id(inp: String) -> void:
	#action_id = "  " + inp + "  "
	#if Engine.is_editor_hint() && has_node("%Input"):
		#%Input.text = "  " + inp + "  "
#
#func _set_action_name(an: String) -> void:
	#action_name = an
	#if Engine.is_editor_hint() && has_node("%Action"):
		#%Action.text = an


func _on_input_pressed() -> void:
	set_process_input(true)
	input.text = "..."
	input.release_focus()
