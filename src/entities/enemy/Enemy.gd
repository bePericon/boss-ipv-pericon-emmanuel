extends CharacterBody2D
class_name Enemy

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var _body_animations: AnimationPlayer = $BodyAnimations
@onready var _body_pivot: Node2D = $BodyPivot
@onready var movement: Movement = $Movement
@onready var raycast: RayCast2D = $RayCast2D
@onready var health: Node = $Health

var target:Node2D = null
var states:EnemyStatesNames = EnemyStatesNames.new()

signal hurting(amount)
signal found

func initialize(container, enemy_pos) -> void:
	container.add_child(self)
	global_position = enemy_pos

func _ready() -> void:
	movement.setup(self)

func _on_detection_area_body_entered(body_detected: Node2D) -> void:
	if target == null and body_detected.name == 'Player':
		target = body_detected
		found_target()

func _on_detection_area_body_exited(body_detected: Node2D) -> void:
	if body_detected == target:
		target = null

func take_damage(amount: int) -> void:
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
	#print("enemy.can_see_target: ", target)
	#var space_state = get_world_2d().direct_space_state
	#var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	#var result = space_state.intersect_ray(query)
	#raycast.set_cas .set_target_position(target.global_position)
	#raycast.force_raycast_update()
	#return raycast.is_colliding() && raycast.get_collider() == target
	return true

func look_at_target() -> void:
	#print("enemy.look_at_target: ", "left" if (target.global_position - global_position).x < 0 else "right")
	_body_pivot.scale.x = -1 if (target.global_position - global_position).x < 0 else 1

func setting_z_index() -> void:
	#print("enemy.setting_z_index: ", "back" if (global_position.y - target.global_position.y) < 0 else "front")
	_body_pivot.z_index = 0 if (global_position.y - target.global_position.y) < 0 else 2

func apply_movement() -> void:
	var direction = target.global_position - global_position
	#var distance = global_position.distance_to(target.global_position)
	movement.move(direction)

func stop_movement() -> void:
	movement.stop_movement()

func is_close_target() -> bool:
	return (global_position - target.global_position) < Vector2(40,10)

func remove() -> void:
	get_parent().remove_child(self)
	queue_free()

func _on_health_dead() -> void:
	get_tree().call_group("Score", "add", 100.0)
