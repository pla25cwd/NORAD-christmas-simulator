extends Sprite2D

func _physics_process(_delta):
	modulate = Color.from_hsv(0, gv.enemy_chances[4] * 0.01, 1, 1)
