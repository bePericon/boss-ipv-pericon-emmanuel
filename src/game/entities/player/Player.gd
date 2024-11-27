extends CharacterBody2D
class_name Player

@export var ACCELERATION:float = 200.0
@export var JUMP_VELOCITY:float = 180.0
@export var jump_control:Vector2 = Vector2.ZERO

@onready var feet_shape: CollisionShape2D = $FeetShape
@onready var _body_pivot: Node2D = $BodyPivot
@onready var hit_box: HitBox = $BodyPivot/HitBox
@onready var _body_animations = $BodyAnimations
@onready var collect_control: Node = $CollectControl
@onready var health: Node = $Health

var states:PlayerStatesNames = PlayerStatesNames.new()

signal player_jumping(is_running)
signal hurting(amount)
signal death

var last_shadow_position:Vector2
var jumping:bool

func _ready() -> void:
	get_tree().call_group("GUI", "set_current_player", self)
	GameState.set_current_player(self)
	last_shadow_position = feet_shape.global_position

func _physics_process(delta: float) -> void:
	#print("feet_shape global: ", feet_shape.global_position)
	#print("shadow_position: ", last_shadow_position)
	if jumping:
		feet_shape.global_position = Vector2(feet_shape.global_position.x, last_shadow_position.y)

func flip_direction() -> void:
	_body_pivot.scale.x = -1 if velocity.x < 0 else 1

func play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)

func take_damage(amount: int) -> void:
	get_tree().call_group("Camera", "apply_shake", 1.0)
	health.take_damage(amount)
	hurting.emit(amount)

func _on_player_state_jumping_running() -> void:
	player_jumping.emit(true)
	jumping = true
	#feet_shape.disabled = true

func _on_player_state_falling_ending() -> void:
	player_jumping.emit(false)
	jumping = false
	#feet_shape.disabled = false

func remove() -> void:
	get_parent().remove_child(self)
	queue_free()

func set_strength(number: int) -> void:
	hit_box.damage = number


func setting_upgrade() -> void:
		modulate =  Color("#24ff00")

func unsetting_upgrade() -> void:
		modulate =  Color("#ffffff")

func _on_health_dead() -> void:
	if health.can_revive():
		get_tree().call_group("GUI", "setting_hearts")

func _on_health_add_health() -> void:
	get_tree().call_group("GUI", "show_heart", health.current_health)

func _on_health_update_health(_amount: int) -> void:
	get_tree().call_group("GUI", "hide_heart", health.current_health+1)

func _on_health_dead_completly(player: Node2D) -> void:
	death.emit()
