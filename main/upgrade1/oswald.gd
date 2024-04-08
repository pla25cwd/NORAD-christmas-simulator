extends Node2D

var remaining_enemies = 30
var targeting = [-1, Node]

func _physics_process(_delta):
	if remaining_enemies <= 0:
		self.queue_free()
	
	if gv.upgrade_state[1] == 0:
		gv.upgrade_state[1] = 1
		
func _on_timer_timeout():
	remaining_enemies -= 1
	$Label.text = str(remaining_enemies)
	$ShapeCast2D.force_shapecast_update()
	if $ShapeCast2D.is_colliding():
		targeting = [-1, $ShapeCast2D]
		for i in $ShapeCast2D.get_collision_count():
			if $ShapeCast2D.get_collider(i).is_in_group("freezable"):
				if $ShapeCast2D.get_collider(i).enemy_choice > targeting[0]:
					targeting[0] = $ShapeCast2D.get_collider(i).enemy_choice
					targeting[1] = $ShapeCast2D.get_collider(i)
		
		$Sprite2D.look_at(targeting[1].position)
		$AudioStreamPlayer2D.play()
		
		if targeting[1] != $ShapeCast2D and targeting[1].enemy_choice != 4:
			targeting[1].nuke()
