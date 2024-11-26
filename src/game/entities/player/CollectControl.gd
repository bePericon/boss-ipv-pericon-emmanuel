extends Node
@onready var upgrade_timer: Timer = $UpgradeTimer

var buffer_collect: Node2D = null
var collectibles_types:CollectibleTypes = CollectibleTypes.new()

func exist_object() -> bool:
	return true if buffer_collect else false

func for_collect(object: Node2D) -> void:
	buffer_collect = object
	
func clear_for_collect() -> void:
	buffer_collect = null

func collected():
	buffer_collect.collected()

func on_collected(type):
	match type:
		collectibles_types.Life:
			notify_score(100.0)
			owner.health.add()
		collectibles_types.Armor:
			notify_score(130.0)
		collectibles_types.Upgrade:
			notify_score(50.0)
			start_upgrade(15.0)

func notify_score(amount: float) -> void:
	get_tree().call_group("Score", "add", amount)

func start_upgrade(time: float) -> void:
	owner.set_strength(3)
	owner.setting_upgrade()
	get_tree().call_group("Score", "set_multiplier", 2.0)
	get_tree().call_group("GUI", "start_upgrade")
	get_tree().call_group("Level", "fast_music")
	upgrade_timer.start(time)
	print("Start upgrade: ", time, " seconds")

func _on_upgrade_timer_timeout() -> void:
	owner.set_strength(1)
	owner.unsetting_upgrade()
	get_tree().call_group("Score", "set_multiplier", 1.0)
	get_tree().call_group("GUI", "end_upgrade")
	get_tree().call_group("Level", "slow_music")
	print("Finished upgrade")
