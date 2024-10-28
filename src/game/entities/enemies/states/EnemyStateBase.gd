extends StateBase
class_name EnemyStateBase

var enemy:Enemy:
	set (value):
		controlled_node = value
	get:
		return controlled_node
