extends Node

@export var health: int = 3

signal dead

func take_damage(amount: int) -> void:
	health -= amount
	if health == 0:
		dead.emit()

func is_dead() -> bool:
	return health == 0
