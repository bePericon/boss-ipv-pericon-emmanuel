extends StateBase
class_name PlayerStateBase

var player:Player:
	set (value):
		controlled_node = value
	get:
		return controlled_node
