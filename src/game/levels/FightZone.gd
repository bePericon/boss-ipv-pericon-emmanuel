extends Area2D
class_name FightZone

@onready var initial_limit: StaticBody2D = $InitialLimit
@onready var end_limit: StaticBody2D = $EndLimit
@onready var timer: Timer = $Timer
@onready var end_zone: CollisionShape2D = $EndZone

@export var enemies_in_zone:int

var finished_zone:bool = false

func _process(_delta: float) -> void:
	if not finished_zone and not have_enemies():
		finished_zone = true
		timer.start(3)
		disable_end_limit()
		get_tree().call_group("Stats", "show_continue")
		get_tree().call_group("Camera", "enable_limits")

func enable_initial_limit() -> void:
	initial_limit.collision_layer = 8

func disable_end_limit() -> void:
	end_limit.collision_layer = 0
	get_parent().remove_child(end_zone)
	queue_free()
	
func enemy_dead() -> void:
	enemies_in_zone -= 1
	print("Remaining enemies: ", enemies_in_zone)

func have_enemies() -> bool:
	return enemies_in_zone != 0

func _on_area_entered(area: Area2D) -> void:
	if area.name == "AlertFightZone":
		enable_initial_limit()
		get_tree().call_group("Camera", "disable_limits", global_position.x + 160)

func _on_timer_timeout() -> void:
	get_tree().call_group("Stats", "hide_continue")
	get_tree().call_group("Camera", "enable_limits")
