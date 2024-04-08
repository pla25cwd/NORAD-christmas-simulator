extends Node2D

var pt_chance = 0.5
var remaining_enemies = 0

func _ready():
	pt_chance = 0.5
	remaining_enemies = 0

func _physics_process(_delta):
	
	gv.debug_pt = pt_chance
	
	if remaining_enemies >= 50:
		self.queue_free()
	
	$Label.text = str(remap(remaining_enemies, 0, 50, 50, 0))

	if gv.upgrade_state[1] == 1:
		gv.upgrade_state[1] = 2
	
	if $ShapeCast2D.is_colliding() and $Timer.time_left == 0:
		$Timer.start()
		for i in $ShapeCast2D.get_collision_count():
			if $ShapeCast2D.get_collider(i).is_in_group("enemies"):
				if randf() >= pt_chance:
					$ShapeCast2D.get_collider(i).enemy_hit()
					remaining_enemies += 1
					if randf() <= pt_chance:
						pt_chance += -0.1
				else:
					if randf() >= pt_chance:
						pt_chance += 0.1
