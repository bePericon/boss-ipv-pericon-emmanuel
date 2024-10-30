extends Node

@export var life_max: int
@export var health_max: int

var current_life:int = 0
var current_health:int = 0

signal dead
signal add_health
signal update_health(amount: int)
signal dead_completly(player: Node2D)

func _ready() -> void:
	current_life = life_max
	current_health = health_max

func take_damage(amount: int) -> void:
	current_health -= amount
	update_health.emit(current_health)
	print("Take damage - current health: ", current_health, " | current life: ", current_life)
	if current_health <= 0:
		current_life -= 1
		current_health = health_max
		dead.emit()
	
	if current_life == 0:
		dead_completly.emit(owner)

func is_dead_completly() -> bool:
	return current_life == 0

func can_revive() -> bool:
	return current_life > 0

func add() -> void:
	if current_health < health_max:
		current_health += 1
		add_health.emit()
		print("Current health: ", current_health)
