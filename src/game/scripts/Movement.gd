extends Node
class_name Movement

@export var speed:float = 32.0

var character: CharacterBody2D

func setup(character2D: CharacterBody2D) -> void:
	character = character2D

func move(input_vector: Vector2) -> void:
	character.velocity = input_vector.normalized() * speed
	character.move_and_slide()

func stop_movement():
	character.velocity = Vector2.ZERO
