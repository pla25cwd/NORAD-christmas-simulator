extends TextureButton

func _physics_process(_delta):
	match gv.upgrade_state[0]:
		0:
			self.tooltip_text = "a freeze ray created in 1957 to unsuccessfully assasinate fidel castro obviously. can freeze all enemies for 3 seconds for some reason. idk."
			self.get_texture_normal().set_region(Rect2(0, 0, 100, 100))
			$Label.text = "250"
		1: 
			self.tooltip_text = "ADVANCED(tm) freeze ray, damages enemies "
			self.get_texture_normal().set_region(Rect2(100, 0, 100, 100))
			$Label.text = "500"
		2:
			self.tooltip_text = "a homemade SCUD-A missile courtesy of hezbollah. it has been modified to carry nuclear-chemical warheads (also homemade) which can kill all enemies on screen."
			self.get_texture_normal().set_region(Rect2(200, 0, 100, 100))
			$Label.text = "1000"
		3:
			self.tooltip_text = "unavailable"
			self.get_texture_normal().set_region(Rect2(300, 0, 100, 100))
			$Label.text = "   "

func _on_pressed():
	match gv.upgrade_state[0]:
		0:
			if gv.score >= 250:
				gv.upgrade_state[0] = 1
				gv.score += -250
				$"/root/main/ui/upgrade_controller/ray/AnimationPlayer".play("new_animation")
		1: 
			if gv.score >= 500:
				gv.upgrade_state[0] = 2
				gv.score += -500
				$"/root/main/ui/upgrade_controller/ray/AnimationPlayer".play("new_animation_2")
		2:
			if gv.score >= 1000:
				gv.upgrade_state[0] = 3
				gv.score += -1000
				$"/root/main/ui/upgrade_controller/nuke/AnimationPlayer".play("new_animation")

func freeze_ray(damage):
	if damage == false:
		get_tree().call_group("enemies", "freeze_ray_0")
	elif damage == true:
		get_tree().call_group("enemies", "freeze_ray_1")

func nuke():
	get_tree().call_group("enemies", "nuke")
