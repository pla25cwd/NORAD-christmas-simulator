extends Node2D

var key_enabled = false

func _ready():
	$Label.hide()
	$VideoStreamPlayer2.hide()

func _on_button_pressed():
	$Label.show()

func _physics_process(_delta):
	if key_enabled and Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_packed(preload("res://main.tscn"))
		gv.shitfuck_captcha = 1
	if $Label.visible:
		if !key_enabled:
			key_enabled = true

func _on_video_stream_player_2_finished():
	Engine.time_scale = [0.5, 0.25, 2, 5].pick_random()
	$VideoStreamPlayer2.hide()

func _on_button_2_pressed():
	$Button2.disabled = true
	$VideoStreamPlayer2.show()
	$VideoStreamPlayer2.play()

func _on_video_stream_player_3_finished():
	$VideoStreamPlayer3.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
