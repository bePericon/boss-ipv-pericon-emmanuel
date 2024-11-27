extends Camera2D

@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func apply_shake(randomStrength: float) -> void:
	shake_strength = randomStrength

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func disable_limits(lim_left: int) -> void:
	limit_left = lim_left
	limit_right = lim_left +320

func enable_limits() -> void:
	print("Enabled camera")
	limit_right = 4800
