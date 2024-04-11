extends AnimationPlayer

func new_speed():
	speed_scale = lerpf(speed_scale, randf_range(0.5, 1.5), 0.75)
