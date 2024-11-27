extends CharacterBody2D
class_name SkeletonBoss

const SPEED = 100.0

@onready var _body_animations: AnimationPlayer = $BodyAnimations
@onready var _body_pivot: Node2D = $BodyPivot
@onready var movement: Movement = $Movement
@onready var health: Node = $Health
@onready var feet_shape: CollisionShape2D = $FeetShape

@export var zone:int 

var target:Node2D = null
var states:SkeletonBossStatesNames = SkeletonBossStatesNames.new()

signal hurting(amount)
signal found

func initialize(container, enemy_pos) -> void:
	container.add_child(self)
	global_position = enemy_pos

func _ready() -> void:
	movement.setup(self)

func _physics_process(_delta: float) -> void:
	setting_z_index()

func _on_detection_area_body_entered(body_detected: Node2D) -> void:
	if target == null and body_detected.name == 'Player':
		target = body_detected
		found_target()

func _on_detection_area_body_exited(body_detected: Node2D) -> void:
	if body_detected == target:
		target = null

func take_damage(amount: int) -> void:
	get_tree().call_group("Camera", "apply_shake", 10.0)
	health.take_damage(amount)
	hurting.emit(amount)

func found_target() -> void:
	found.emit()

func play_animation(animation: String) -> void:
	if _body_animations.has_animation(animation):
		_body_animations.play(animation)

func can_see_target() -> bool:
	if not target:
		return false
	return true

func look_at_target() -> void:
	_body_pivot.scale.x = -1 if (target.global_position - global_position).x < 0 else 1

func setting_z_index() -> void:
	if target:
		_body_pivot.z_index = 0 if (feet_shape.global_position.y - target.feet_shape.global_position.y) < 0 else 2

func apply_movement() -> void:
	var direction = target.global_position - global_position
	#if(global_position.x < 4750 and global_position.x > 4410):
	movement.move(direction)

func stop_movement() -> void:
	movement.stop_movement()

func is_close_target() -> bool:
	var vector = (global_position - target.global_position)
	return Vector2(abs(vector.x), abs(vector.y)) < Vector2(80,20)

func remove() -> void:
	get_parent().remove_child(self)
	queue_free()

func _on_health_dead() -> void:
	get_tree().call_group("Score", "add", 500.0)


func _on_health_dead_completly(body: Node2D) -> void:
	get_tree().call_group("Score", "add", 300.0)
	get_tree().call_group("FightControl", "enemy_dead", zone)
