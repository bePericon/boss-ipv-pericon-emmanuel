extends Node

@export var life_max: int
@export var health_max: int

var current_life:int = 0
var current_health:int = 0

signal dead

func _ready() -> void:
	current_life = life_max
	current_health = health_max

func take_damage(amount: int) -> void:
	current_health -= amount
	print("Take damage - current health: ", current_health, " | current life: ", current_life)
	if current_health == 0:
		current_life -= 1
		current_health = health_max
		dead.emit()

func is_dead() -> bool:
	return current_life == 0

func can_revive() -> bool:
	return current_life > 0

func add() -> void:
	if current_health < health_max:
		current_health += 1
		print("Current health: ", current_health)
