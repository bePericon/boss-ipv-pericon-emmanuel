extends CharacterBody2D

@export var ACCELERATION:float = 300.0
@export var H_SPEED_LIMIT:float = 600.0
@export var FRICTION_WEIGHT:float = 1.1
@export var JUMP_VELOCITY:float = -400.0

@onready var _body_pivot: Node2D = $BodyPivot
@onready var _body_animations = $BodyAnimations

func _ready() -> void:
	_body_animations.play("idle")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITYInput.is_action_pressed("ui_right")
	
	# Player movement
	var h_movement_direction:int = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var v_movement_direction:int = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	# Horirizontal control
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		_body_pivot.scale.x = 1 - 2 * float(h_movement_direction < 0)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	# Vertical control
	if v_movement_direction != 0:
		velocity.y = clamp(velocity.y + (v_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.y = lerp(velocity.y, 0.0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0
	
	if Input.is_action_just_pressed("attack_01"):
		_play_animation("attack_01")
	
	if not _body_animations.is_playing():
		if velocity != Vector2.ZERO:
			_play_animation("run")
			move_and_slide()
		else:
			_play_animation("idle")
			
	#if h_movement_direction != 0 || v_movement_direction != 0:
		#_play_animation("run")
		#move_and_slide()
	#elif Input.is_action_just_pressed("attack_01"):
		#_play_animation("attack_01")
	#else:
		#_play_animation("idle")

	
func _play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)
