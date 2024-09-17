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


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var axis = get_input_axis()
	
	is_attacking = _body_animations.current_animation == "attack_01"
	
	if axis == Vector2.ZERO:
		if not is_jumping and not is_attacking:
			_play_animation("idle")
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
		
	else:
		if not is_jumping and not is_attacking:
			_play_animation("run")
		velocity.x = clamp(velocity.x + (axis.x * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
		
	if Input.is_action_just_pressed("attack_01"):
		attack()
	
	if position.y > 104 and !is_jumping:
		if axis.y != 0:
			velocity.y = clamp(velocity.y + (axis.y * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
		else:
			velocity.y = lerp(velocity.y, 0.0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0

	if position.y < 104 and !is_jumping:
		velocity.y = 105

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


func get_input_axis() -> Vector2:
	var axis = Vector2.ZERO
	# Player movement
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	_body_pivot.scale.x = 1 - 2 * float(axis.x < 0)
	return axis.normalized()


func _play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)


func move() -> void:
	is_moving = true
	_play_animation("run")
	is_moving = false


func attack() -> void:
	is_attacking = true
	_play_animation("attack_01")
	is_attacking = false


func jump() -> void:
	is_jumping = true
	_play_animation("jump")
	is_jumping = false
