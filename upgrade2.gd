extends TextureButton

func _physics_process(_delta):
	match gv.upgrade_state[2]:
		0:
			self.tooltip_text = "Monster™ Energy™ Zero™ Ultra. verursacht kardiovaskuläri erkrankig."
			self.get_texture_normal().set_region(Rect2(0, 0, 100, 100))
			$Label.text = "100"
		1: 
			self.tooltip_text = "heals 25 health."
			self.get_texture_normal().set_region(Rect2(100, 0, 100, 100))
			$Label.text = "250"
		2:
			self.tooltip_text = "ketamine. its ketamine. you get it."
			self.get_texture_normal().set_region(Rect2(200, 0, 100, 100))
			$Label.text = "500"
		3:
			self.tooltip_text = "slot unavailable."
			self.get_texture_normal().set_region(Rect2(300, 0, 100, 100))
			$Label.text = "   "

func _on_pressed():
	match gv.upgrade_state[2]:
		0:
			if gv.score >= 100:
				gv.upgrade_state[2] = 1
				gv.health += 10
				gv.score += -100
		1: 
			if gv.score >= 250:
				gv.upgrade_state[2] = 2
				gv.health += 25
				gv.score += -250
		2:
			if gv.score >= 500:
				gv.upgrade_state[2] = 3
				gv.health += 25
				gv.score += -250
