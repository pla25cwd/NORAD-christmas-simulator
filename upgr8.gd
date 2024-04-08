extends Control

var panel2 = true

func _physics_process(_delta):
	if gv.score <= 10000:
		visible = false
		$Button.disabled = true
	elif gv.score >= 10000:
		visible = true
		$Button.disabled = false
	if panel2 == true:
		var offsets = $Panel2/Panel.get_theme_stylebox("panel").texture.color_ramp.offsets
		for i in offsets.size():
			offsets.set(i, randf_range(0.001, 1.000))
		$Panel2/Panel.get_theme_stylebox("panel").texture.color_ramp.offsets = offsets
		$Panel2/Panel.get_theme_stylebox("panel").texture.noise.seed = randi()
		$Panel2/Panel/Panel.get_theme_stylebox("panel").skew = Vector2(randf_range(-0.1, 0.1), randf_range(-0.01, 0.01))

	if gv.hat == true:
		self.queue_free()

func _on_button_pressed():
	gv.disable_mouse = true
	$Panel2.visible = true
	
	if gv.score >= 100000:
		$Panel2/Panel/Panel/nuh.visible = true
		$Panel2/Panel/Panel/fuckhead.visible = false
		$Panel2/Panel/Panel/yep.visible = true
	elif gv.score <= 100000:
		$Panel2/Panel/Panel/nuh.visible = false
		$Panel2/Panel/Panel/fuckhead.visible = true
		$Panel2/Panel/Panel/yep.visible = false


func _on_fuckhead_pressed():
	$Panel2.visible = false
	gv.disable_mouse = false

func _on_nuh_pressed():
	gv.disable_mouse = false
	$Panel2.visible = false

func _on_yep_pressed():
	panel2 = false
	if gv.score >= 100000:
		$Panel2.queue_free()
		self.add_child(preload("res://captcha.tscn").instantiate())
