extends StateBase
class_name SkeletonBossStateBase

var enemy:SkeletonBoss:
	set (value):
		controlled_node = value
	get:
		return controlled_node
