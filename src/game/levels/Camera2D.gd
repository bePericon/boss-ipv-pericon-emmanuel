extends Camera2D

func disable_limits(lim_left: int) -> void:
	limit_left = lim_left
	limit_right = lim_left +320

func enable_limits() -> void:
	print("Enabled camera")
	limit_right = 4800
