extends Node2D

var health = 250
var enemy_choice = gv.enemy_choice
@export var can_fire = true
var texture_array = [preload("res://main/sheet_enemy_0.png"), preload("res://main/sheet_enemy_1.png"), preload("res://main/sheet_enemy_2.png"), preload("res://main/sheet_enemy_3.png"), preload("res://main/sheet_enemy_4.png")]
var collider_array = [preload("res://main/enemy_colliders/0.tres"), preload("res://main/enemy_colliders/1.tres"), preload("res://main/enemy_colliders/2.tres"), preload("res://main/enemy_colliders/3.tres"), preload("res://main/enemy_colliders/4.tres")]
var score_add = 10
var ec1_i = 4
var atk_chance = 0.75
var new_bullet_type : int

func _ready():
	$Sprite2D.set_texture(texture_array[enemy_choice])
	match enemy_choice:
		0:
			health = 100
			score_add = 25
			atk_chance = 0.75
			$x.speed_scale = 1.0 + randf_range(-0.2, 0.2)
		1:
			health = 250
			score_add = 50
			atk_chance = 0.75
			$x.speed_scale = 0.8 + randf_range(-0.2, 0.2)
		2:
			health = 500
			score_add = 100
			atk_chance = 0.66
			$x.speed_scale = 1.0 + randf_range(-0.2, 0.2)
		3:
			health = 750 
			score_add = 1000
			$x.speed_scale = 1.5 + randf_range(-0.2, 0.2)
			atk_chance = 0.5
		4:
			health = 2500
			score_add = 10000
			$x.speed_scale = 1.5 + randf_range(-0.2, 0.2)
			atk_chance = 0.33

	if enemy_choice == 4:
		scale = Vector2(1, 1)
	else:
		scale = Vector2(0.5, 0.5)
		
	update_y()
	if randf_range(0, 100) >= 50:
		$x.play_backwards("x")
	else:
		$x.play("x")
		$Sprite2D.flip_h = true

func update_y():
	var rand = randi_range(-50, 100)
	$Sprite2D.position.y = rand
	$CollisionShape2D.position.y = rand

func enemy_hit(damage : int, animation : bool):
	health -= damage
	$AnimationPlayer.play("reset")
	if health <= 0:
		gv.kills += 1
		gv.score += score_add
		gv.actual_score += score_add
		if enemy_choice != 4:
			gv.enemy_chances[enemy_choice] -= 1
		gv.enemy_chances[clampi(enemy_choice + 1, 0, 4)] += 1
		if animation:
			$AnimationPlayer.play("death")
			$x.pause()
			$y.pause()
	elif animation:
		$AnimationPlayer.play("hit")

func _on_timer_timeout():
	if randf() >= atk_chance and can_fire == true and gv.attack_sum and $AnimationPlayer.current_animation != "death":
		match enemy_choice:
			0:
				sound("res://main/sounds/fire_0.wav")
				new_bullet_type = 0
				fire()
			1:
				ec1_i = 3
				$ec1_timer.start(0.5)
				new_bullet_type = 1
			2:
				sound("res://main/sounds/fire_2.wav")
				new_bullet_type = 2
				fire()
			3:
				if randf() >= 0.5:
					ec1_i = 10
					$ec1_timer.start(0.1)
					new_bullet_type = 3
				else:
					sound("res://main/sounds/fire_3.wav")
					new_bullet_type = 2
					fire()
			4:
					ec1_i = 10
					$ec1_timer.start(0.1)
					new_bullet_type = 3

func fire():
	gv.attack_sum = false
	var bullet = load("res://main/bullets/enemy_0_bullet.tscn").instantiate()
	bullet.bullet_type = new_bullet_type
	get_node("/root/main").add_child(bullet)
	bullet.position = position
	if new_bullet_type == 2 or new_bullet_type == 0:
		bullet.look_at(Vector2(randf_range(200, 600), 450))
	else:
		bullet.look_at(Vector2(400, 450))

func freeze_ray_0():
	if enemy_choice != 4:
		$AnimationPlayer2.play("freeze_0")
	else:
		$AnimationPlayer2.play("freeze_2_4")
	
func freeze_ray_1():
	if enemy_choice != 4:
		$AnimationPlayer2.play("freeze_1")
	else:
		$AnimationPlayer2.play("freeze_2_5")
	
func bullet_hit():
	pass

func flip(flip_b):
	$Sprite2D.flip_h = flip_b

func _on_ec_1_timer_timeout():
	if ec1_i >= 0:
		ec1_i -= 1
		sound("res://main/sounds/fire_1.wav")
		fire()
		$ec1_timer.start(0.2)

func sound(stream):
	if stream == "corpse":
		if !$corpse.playing:
			$corpse.stream = load("res://main/sounds/corpse_" + str(enemy_choice) + ".wav")
			$corpse.play()
	elif !$fire.playing:
		$fire.stream = load(stream)
		$fire.play()
