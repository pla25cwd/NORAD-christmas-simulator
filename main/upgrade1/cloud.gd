extends Sprite2D

var remaining_enemies = 0

func _ready():
	remaining_enemies = 0

func _physics_process(_delta):
	$Label.text = str(remap(remaining_enemies, 0, 100, 100, 0))
	
	$Sprite2D.modulate = Color(1, 1, 1, remaining_enemies * 0.01)
	
	if remaining_enemies >= 100:
		self.queue_free()

	if gv.upgrade_state[1] == 2:
		gv.upgrade_state[1] = 3
		
	if $ShapeCast2D.is_colliding() and $Timer.time_left == 0:
		for i in $ShapeCast2D.get_collision_count():
			if $ShapeCast2D.get_collider(i).is_in_group("enemies"):
				$ShapeCast2D.get_collider(i).enemy_hit()
				remaining_enemies += 1
				$Timer.start()
