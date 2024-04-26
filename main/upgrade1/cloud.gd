extends Sprite2D

var remaining_enemies : int = 100
var shapecast : ShapeCast2D
var cracks : Sprite2D
var label : Label

func _ready():
	remaining_enemies = 100
	shapecast = $ShapeCast2D
	cracks = $Sprite2D
	label = $Label

func _physics_process(_delta):
	label.text = str(remaining_enemies)
	cracks.modulate = Color(1, 1, 1, (remap(remaining_enemies, 0, 100, 100, 0)) * 0.01)
	
	if remaining_enemies <= 0:
		self.queue_free()

	if gv.upgrade_state[1] == 2:
		gv.upgrade_state[1] = 3
		
	if shapecast.is_colliding():
		for i in shapecast.get_collision_count():
			if shapecast.get_collider(i).is_in_group("enemies"):
				shapecast.get_collider(i).enemy_hit()
				remaining_enemies -= 1
