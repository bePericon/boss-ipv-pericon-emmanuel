extends Node

var buffer_collect: Node2D = null

func exist_object() -> bool:
	return true if buffer_collect else false

func for_collect(object: Node2D) -> void:
	buffer_collect = object
	
func clear_for_collect() -> void:
	buffer_collect = null

func collected():
	buffer_collect.collected()
