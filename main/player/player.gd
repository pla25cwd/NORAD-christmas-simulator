extends Sprite2D

var aim_position = Vector2.ZERO
var tw = -1
var heat = 0
var heat_capacity = 100
@export var target_pitch = 0.8

func _physics_process(_delta):
	if gv.weapon_state != tw:
		match gv.weapon_state:
			0:
				$pcc.play("0")
				tw = 0
				heat_capacity = 100
			1:
				$pcc.play("1")
				tw = 1
				heat_capacity = 500
			2:
				$pcc.play("2")
				tw = 2
				heat_capacity = 1000
	$gun/barrel_point/AudioStreamPlayer2D.pitch_scale = target_pitch

	if gv.garbagemode[1]:
		$Timer.wait_time = remap(heat_capacity - heat, heat_capacity, 0, 0.25, 0.5)
		$gun/barrel_point/AudioStreamPlayer2D.volume_db = remap($Timer.wait_time, 0.25, 0.5, 0, -12)
		$gun/barrel_point/hiss.volume_db = remap($Timer.wait_time, 0.25, 0.5, -40, 0)
		$gun/Sprite2D.modulate = Color(1, 1, 1, remap($Timer.wait_time, 0.25, 0.5, 0, 1))
		$gun/barrel_point/AudioStreamPlayer2D.pitch_scale = remap($Timer.wait_time, 0.25, 0.5, target_pitch, target_pitch - 0.5)
		
	if get_viewport().get_mouse_position().y < 350 	 and !$"../ui/Button".is_pressed() and gv.disable_mouse == false:
		$gun.look_at(get_viewport().get_mouse_position())
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and $Timer.time_left == 0:
			if gv.garbagemode[1]:
				fire()
				heat += 1
				$heat_timer.start()
			else:
				fire()
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$gun/barrel_point/AudioStreamPlayer2D.stream_paused = false
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$gun/barrel_point/AudioStreamPlayer2D.stream_paused = true

	gv.health = clampi(gv.health, 0, 100)
	if gv.health == 0:
		get_tree().change_scene_to_packed(preload("res://end.tscn"))
	
	if $ShapeCast2D.is_colliding():
		for i in $ShapeCast2D.get_collision_count():
			if $ShapeCast2D.get_collider(i).is_in_group("enemies") and $ShapeCast2D/Timer.time_left == 0:
				$ShapeCast2D.get_collider(i).bullet_hit()
				$ShapeCast2D/Timer.start()
	
func fire():
	$Timer.start()
	var bullet = preload("res://bullet.tscn").instantiate()
	add_child(bullet)
	bullet.global_transform = $gun/barrel_point.global_transform


func _on_audio_stream_player_2d_finished():
	# fix stupid bullshit
	$gun/barrel_point/AudioStreamPlayer2D.stream = preload("res://main/player/firing_0.wav")
	$gun/barrel_point/AudioStreamPlayer2D.play()

func _on_heat_timer_timeout():
	if gv.garbagemode[1]:
		heat = clampi(heat - 5, 0, heat_capacity)

func _on_link_button_pressed():
	JavaScriptBridge.eval("close();")

func _on_hiss_finished():
	$gun/barrel_point/hiss.stream = preload("res://main/sounds/hiss.wav")
	$gun/barrel_point/hiss.play()
