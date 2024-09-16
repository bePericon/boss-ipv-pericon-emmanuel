extends CharacterBody2D

@export var ACCELERATION:float = 50.0
@export var SPEED_LIMIT:float = 600.0
@export var FRICTION_WEIGHT:float = 1.1
@export var JUMP_VELOCITY:float = -400.0

@onready var _body_pivot: Node2D = $BodyPivot
@onready var _body_animations = $BodyAnimations

var is_moving:bool = false
var is_attacking:bool = false
var is_jumping:bool = false

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	is_attacking = _body_animations.current_animation == "attack_01"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):# and is_on_floor():
		print("jumping")
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var v_movement_direction:int = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	# Horirizontal control
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
		_body_pivot.scale.x = 1 - 2 * float(h_movement_direction < 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	# Vertical control
	if v_movement_direction != 0:
		velocity.y = clamp(velocity.y + (v_movement_direction * ACCELERATION), -SPEED_LIMIT, SPEED_LIMIT)
	else:
		#print("v_movement_direction != 0 else")
		velocity.y = lerp(velocity.y, 0.0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0
	
	
	
	if h_movement_direction != 0 or v_movement_direction != 0:
		move()
	elif Input.is_action_just_pressed("attack_01"):
		attack()
	elif not is_moving and not is_attacking:
		_play_animation("idle")
		

	
func _play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)


func move() -> void:
	is_moving = true
	_play_animation("run")
	move_and_slide()
	is_moving = false


func attack() -> void:
	is_attacking = true
	_play_animation("attack_01")
	is_attacking = false


func _on_jump_buffer_timer_timeout() -> void:
	pass # Replace with function body.
