extends CharacterBody2D
class_name Player

@export var ACCELERATION:float = 200.0
@export var JUMP_VELOCITY:float = 250.0
@export var jump_control:Vector2 = Vector2.ZERO

@onready var feet_shape: CollisionShape2D = $FeetShape
@onready var _body_pivot: Node2D = $BodyPivot
@onready var _body_animations = $BodyAnimations
@onready var collect_control: Node = $CollectControl
@onready var health: Node = $Health

var states:PlayerStatesNames = PlayerStatesNames.new()
var strength:int = 1

signal player_jumping(is_running)
signal hurting(amount)

func flip_direction() -> void:
	_body_pivot.scale.x = -1 if velocity.x < 0 else 1


func play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)

func take_damage(amount: int) -> void:
	health.take_damage(amount)
	hurting.emit(amount)

func _on_player_state_jumping_running() -> void:
	player_jumping.emit(true)


func _on_player_state_falling_ending() -> void:
	player_jumping.emit(false)

func remove() -> void:
	get_parent().remove_child(self)
	queue_free()

func set_strength(number: int) -> void:
	strength = number
