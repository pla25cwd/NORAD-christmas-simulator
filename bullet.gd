extends Node2D

var movement_speed = -10

func _ready():
	$Area2D.monitoring = true
	match gv.weapon_state:
		0:
			$Sprite2D.region_rect = Rect2(0, 0, 40, 20)
			movement_speed = -7.5
			$Area2D/CollisionShape2D.shape.size = Vector2(5, 15)
			global_rotation = global_rotation + randi_range(-100, 100)
		1:
			$Sprite2D.region_rect = Rect2(0, 20, 40, 20)
			movement_speed = -10
			$Area2D/CollisionShape2D.shape.size = Vector2(10, 20)
			global_rotation = global_rotation + randi_range(-1, 1)
		2:
			$Sprite2D.region_rect = Rect2(0, 40, 40, 20)
			movement_speed = -10
			$Area2D/CollisionShape2D.shape.size = Vector2(25, 25)
			global_rotation = global_rotation + randi_range(-25, 25)


func _physics_process(_delta):
	if !$AnimationPlayer.current_animation == "hit" and !$AnimationPlayer.current_animation == "hit_r":
		if $Area2D.has_overlapping_bodies():
			for i in $Area2D.get_overlapping_bodies():
				if i.is_in_group("enemies"):
					i.enemy_hit()
					if gv.garbagemode[0]:
						gv.score += 1
					if gv.weapon_state == 2:
						$AnimationPlayer.play("hit_r")
					else:
						$AnimationPlayer.play("hit")
		move_local_y(movement_speed)

func _on_timer_timeout():
	$AnimationPlayer.play("hit")
	if gv.garbagemode[0]:
		gv.score += -1

func _on_timer_2_timeout():
	match gv.weapon_state:
		0:
			rotation = rotation + randf_range(-0.1, 0.1)
		1:
			rotation = rotation + randf_range(-0.05, 0.05)
		2:
			rotation = rotation + randf_range(-0.5, 0.5)
