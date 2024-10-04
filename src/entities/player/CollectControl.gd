extends Node
@onready var upgrade_timer: Timer = $UpgradeTimer

var buffer_collect: Node2D = null
var collectibles_types:CollectibleTypes = CollectibleTypes.new()
var score_multiplier:float = 1.0

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
			start_upgrade(10)

func notify_score(amount: float) -> void:
	var score = amount * score_multiplier
	get_tree().call_group("Score", "add", score)

func start_upgrade(time: float) -> void:
	owner.set_strength(3)
	score_multiplier += 0.3
	get_tree().call_group("Score", "add_multiplier", 0.3)
	print("Start upgrade: ", time, " seconds")
	upgrade_timer.start(time)

func _on_upgrade_timer_timeout() -> void:
	owner.set_strength(1)
	score_multiplier = 1
	get_tree().call_group("Score", "set_multiplier", 1.0)
	print("Finished upgrade")
	upgrade_timer.stop()
