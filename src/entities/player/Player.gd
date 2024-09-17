extends CharacterBody2D

@export var ACCELERATION:float = 50.0
@export var SPEED_LIMIT:float = 200.0
@export var FRICTION_WEIGHT:float = 1.1
@export var JUMP_VELOCITY:float = 25.0
var JUMP_MULTIPLICATOR:float = 15.0

@onready var _body_pivot: Node2D = $BodyPivot
@onready var _body_animations = $BodyAnimations

var is_moving:bool = false
var is_attacking:bool = false
var is_jumping:bool = false
var z:float = 0.0

func _physics_process(delta: float) -> void:
	#Horizontal Movement
	var h_movement_direction: int = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
		_body_pivot.scale.x = 1 - 2 * float(h_movement_direction < 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
		
	#Vertical Movement
	var v_movement_direction: int = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if v_movement_direction != 0 and position.y > 104 and !is_jumping:
		velocity.y = clamp(velocity.y + (v_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
	else:
		velocity.y = lerp(velocity.y, 0.0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0
		
	if position.y < 104 and !is_jumping:
		velocity.y = 105
	
	is_attacking = _body_animations.current_animation == "attack_01"
	
	if h_movement_direction != 0 or v_movement_direction != 0 and not is_jumping and not is_attacking:
		_play_animation("run")
	elif not is_jumping and not is_attacking:
		_play_animation("idle")
		
	if Input.is_action_just_pressed("attack_01"):
		is_attacking = true
		_play_animation("attack_01")
		is_attacking = false

	if Input.is_action_just_pressed("jump") and !is_jumping:
		is_jumping = true
		_play_animation("jump")
		z += -JUMP_VELOCITY * JUMP_MULTIPLICATOR
		
	if z > 25 * JUMP_MULTIPLICATOR:
		is_jumping = false
		z = 0
		velocity.y = 0
	
	if is_jumping:
		var gravity = get_gravity() * delta
		z += gravity.y
		if z > 0 and !is_attacking:
			_play_animation("fall")
		velocity.y = z -10
		
	move_and_slide()


func _play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)
