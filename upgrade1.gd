extends TextureButton

func _physics_process(_delta):
	match gv.upgrade_state[1]:
		0:
			self.tooltip_text = "lee harvery oswald. kills enemies of high political importance. ocassionally."
			self.get_texture_normal().set_region(Rect2(0, 0, 100, 100))
			$Label.text = "1000"
		1: 
			self.tooltip_text = "crashed AQI satellite. doesnt work very well."
			self.get_texture_normal().set_region(Rect2(100, 0, 100, 100))
			$Label.text = "2500"
		2:
			self.tooltip_text = "big cloud."
			self.get_texture_normal().set_region(Rect2(200, 0, 100, 100))
			$Label.text = "5000"
		3:
			self.tooltip_text = "slot unavailable."
			self.get_texture_normal().set_region(Rect2(300, 0, 100, 100))
			$Label.text = "   "

func _on_pressed():
	match gv.upgrade_state[1]:
		0:
			if gv.score >= 1000:
				gv.upgrade_state[1] = 1
				gv.score += -1000
				$"/root/main/ui/upgrade_controller".add_child(preload("res://main/upgrade1/oswald.tscn").instantiate())
		1: 
			if gv.score >= 2500:
				gv.upgrade_state[1] = 2
				gv.score += -2500
				$"/root/main/ui/upgrade_controller".add_child(preload("res://main/upgrade1/sdi.tscn").instantiate())
		2:
			if gv.score >= 5000:
				gv.upgrade_state[1] = 3
				gv.score += -5000
				$"/root/main/ui/upgrade_controller".add_child(preload("res://main/upgrade1/cloud.tscn").instantiate())
