extends Node2D

var key_enabled = false

#get_tree().change_scene("res://main.tscn")
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Label.hide()
	get_tree().set_auto_accept_quit(false)

func _on_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Label.show()
	key_enabled = true

func _physics_process(_delta):
	if key_enabled and Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_packed(preload("res://main.tscn"))
		gv.shitfuck_captcha = 1


func _on_link_button_pressed():
	get_tree().quit()

func _on_video_stream_player_2_finished():
	get_tree().quit()


func _on_button_2_pressed():
	$Button2.disabled = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$VideoStreamPlayer2.show()
	$VideoStreamPlayer2.play()


func _on_video_stream_player_3_finished():
	$VideoStreamPlayer3.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_timer_timeout():
	if key_enabled:
		get_tree().change_scene_to_packed(preload("res://main.tscn"))
		gv.shitfuck_captcha = 1
