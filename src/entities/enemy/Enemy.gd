extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var body_animations: AnimationPlayer = $BodyAnimations
@onready var body: Sprite2D = $Body
var target:Node2D = null

func _physics_process(_delta: float) -> void:
	if(target and target.name == 'Player'):
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(PhysicsRayQueryParameters2D.create(global_position, target.global_position))
		if(result):
			body.flip_h = (result.position.x - target.global_position.x) > 0
			body.z_index = 0 if (result.position.y - target.global_position.y) < 0 else 2


func _on_detection_area_body_entered(body_detected: Node2D) -> void:
	if target == null and body_detected.name == 'Player':
		target = body_detected


func _on_detection_area_body_exited(body_detected: Node2D) -> void:
	if body_detected == target:
		target = null


func take_damage(_amount: int) -> void:
	body_animations.play("hit")


func _on_body_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		body_animations.play("idle")
