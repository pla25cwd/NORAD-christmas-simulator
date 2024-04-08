extends Sprite2D

var particles_and_shit = true
var arrows = 0

func _ready():
	hide()

func _physics_process(_delta):
		
	if gv.hat == true:
		show()
		if particles_and_shit == true:
			particles_and_shit = false
			
			$VideoStreamPlayer.play()

func _on_timer_timeout():
	if arrows <= 5:
		arrows += 1
		$Sprite2D.rotation_degrees = randi_range(-360, 360)
		$Sprite2D.visible = !$Sprite2D.visible
		$Sprite2D/Timer.start()


func _on_video_stream_player_finished():
	$Sprite2D/Timer.start()
