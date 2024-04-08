extends Label

func _on_timer_timeout():
	get_tree().quit()

func _on_timer_2_timeout():
	$Timer2.start(randf_range(0, 0.2))
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	text = "you successfully failed to win! \n \n detonating Intel Management Engine IED in \n " + str($Timer.time_left + randf_range(-0.25, 0.25))
