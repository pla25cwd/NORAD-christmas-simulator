extends Node2D

var key_enabled = false

func _ready():
	$Label.hide()

func _on_button_pressed():
	$Label.show()
	key_enabled = true

func _physics_process(_delta):
	if key_enabled and Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_packed(preload("res://main.tscn"))
		gv.shitfuck_captcha = 1


func _on_link_button_pressed():
	JavaScriptBridge.eval("close();")	

func _on_video_stream_player_2_finished():
	JavaScriptBridge.eval("close();")


func _on_button_2_pressed():
	$Button2.disabled = true
	$VideoStreamPlayer2.show()
	$VideoStreamPlayer2.play()


func _on_video_stream_player_3_finished():
	$VideoStreamPlayer3.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
