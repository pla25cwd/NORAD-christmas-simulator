extends Label

func _on_timer_timeout():
	JavaScriptBridge.eval("close();")

func _on_timer_2_timeout():
	$Timer2.start(randf_range(0, 0.2))
	text = "you successfully failed to win! \n \n detonating Intel Management Engine IED in \n " + str($Timer.time_left + randf_range(-0.25, 0.25))
