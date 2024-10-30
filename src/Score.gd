extends Node
class_name Score

var total_score:float = 0.0
var score_multiplier:float = 1.0

signal updated_score(amount)

func add(amount: float) -> void:
	print("Score - Add: ", amount)
	total_score += amount * score_multiplier
	updated_score.emit(total_score)
	print("Score - Total: ", total_score)

func add_multiplier(number: float) -> void:
	score_multiplier += number

func set_multiplier(number: float) -> void:
	score_multiplier = number
