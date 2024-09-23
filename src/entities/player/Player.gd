extends CharacterBody2D
class_name Player

@export var ACCELERATION:float = 200.0
@export var JUMP_VELOCITY:float = 180.0

@export var jump_control:Vector2 = Vector2.ZERO

@onready var _body_pivot: Node2D = $BodyPivot
@onready var _body_animations = $BodyAnimations
@onready var collect_control: Node = $CollectControl


func flip_direction() -> void:
	_body_pivot.scale.x = -1 if velocity.x < 0 else 1


func play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)


#func _handle_jump(delta: float) -> void:
	#if Input.is_action_just_pressed("jump") and !is_jumping:
		#is_jumping = true
		#_play_animation("jump")
		#z += -JUMP_VELOCITY * JUMP_MULTIPLICATOR
		#
	#if z > 25 * JUMP_MULTIPLICATOR:
		#is_jumping = false
		#z = 0
		#velocity.y = 0
	#
	#if is_jumping:
		#var gravity = get_gravity() * delta
		#z += gravity.y
		#if z > 0 and !is_attacking:
			#_play_animation("fall")
		#velocity.y = z -10
