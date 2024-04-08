extends Control

var enabled = false

func _physics_process(_delta):
	$BoxContainer.visible = enabled
	if gv.esports_menu_enabled_fuck:
			gv.esports_menu_enabled_fuck = false
			$TextureRect.texture.region = Rect2(32, 0, 32, 32)
			enabled = true
	
	for i in $BoxContainer.get_children().size() :
		gv.garbagemode[i] = $BoxContainer.get_child(i).button_pressed
		if $BoxContainer.get_child(i).button_pressed:
			$BoxContainer.get_child(i).get_child(0).texture.region = Rect2(32, 0, 32, 32)
		else:
			$BoxContainer.get_child(i).get_child(0).texture.region = Rect2(0, 0, 32, 32)
		
func _on_button_pressed():
	match enabled:
		false:
			if $Marker2D.get_child_count() == 0:
				$Marker2D.add_child(preload("res://captcha.tscn").instantiate())
			else:
				$Marker2D.get_child(0).queue_free()
		true:
			$TextureRect.texture.region = Rect2(0, 0, 32, 32)
			enabled = false
