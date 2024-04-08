extends Control

var target = [true, true, true, true, true, true, true, true, true]
var current = [false, false, false, false, false, false, false, false, false]
var rect_up = []
var rect_down = []
@onready var nodes = [$"bg_c/images/0", $"bg_c/images/1", $"bg_c/images/2", $"bg_c/images/3", $"bg_c/images/4", $"bg_c/images/5", $"bg_c/images/6", $"bg_c/images/7", $"bg_c/images/8"]

func _ready():
	$bg_c/Submit/TextureRect.visible = false
	reset_array()
	update()
	$bg_c/Submit/Panel.visible = false
	$bg_c/Submit.disabled = false
	match gv.shitfuck_captcha:
		0:
			$bg.visible = false
		1:
			$bg.visible = true
			
func _on_submit_mouse_entered():
	$bg_c/Submit.remove_theme_font_override("font")
	$bg_c/Submit.add_theme_font_override("font", preload("res://menu/gamefont(1).ttf"))
	
func _on_submit_mouse_exited():
	$bg_c/Submit.remove_theme_font_override("font")
	$bg_c/Submit.add_theme_font_override("font", preload("res://menu/MINGLIU.ttf"))

func reset_array():
	for n in [rect_up, rect_down]:
		n.clear()
		for i in 24:
			n.append(i)
		n.shuffle()

func update():
	reset_array()
	for i in target.size():
		if randf() >= 0.75:
			target[i] = true
		else:
			target[i] = false
	
	for i in target.size():
		nodes[i].get_child(0).button_pressed = false
		if target[i] == true:
			rect_up.shuffle()
			nodes[i].texture.region = Rect2((rect_up[0] * 100), 0, 100, 100)
			rect_up.remove_at(0)
		elif target[i] == false:
			rect_down.shuffle()
			nodes[i].texture.region = Rect2((rect_down[0] * 100), 100, 100, 100)
			rect_down.remove_at(0)

	for i in nodes.size():
		nodes[i].get_child(0).disabled = false
		
func _on_submit_pressed():
	$bg_c/Submit.disabled = true
	$bg_c/Submit/Timer.start(randf_range(3, 10))
	$bg_c/Submit/TextureRect.visible = true
	for i in nodes.size():
		nodes[i].get_child(0).disabled = true

func _on_timer_timeout():
	$bg_c/Submit/TextureRect.visible = false
	for i in target.size():
		current[i] = nodes[i].get_child(0).button_pressed
	if current == target:
		match gv.shitfuck_captcha:
			0:
				gv.esports_menu_enabled_fuck = true
				self.queue_free()
			1:
				gv.hat = true
				gv.disable_mouse = false
	elif current != target:
		$bg_c/Submit/Timer2.start()
		$bg_c/Submit/Panel.visible = true
		update()

func _on_timer_2_timeout():
	$bg_c/Submit.disabled = false
	$bg_c/Submit/Panel.visible = false

func _physics_process(_delta):
	$bg_c/Submit/TextureRect/AnimationPlayer.speed_scale = randf_range(0.5, 1)
