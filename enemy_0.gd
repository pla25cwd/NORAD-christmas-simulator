extends Node2D

var health = 250
var enemy_choice = gv.enemy_choice
@export var can_fire = true
var texture_array = [preload("res://main/sheet_enemy_0.png"), preload("res://main/sheet_enemy_1.png"), preload("res://main/sheet_enemy_2.png"), preload("res://main/sheet_enemy_3.png"), preload("res://main/sheet_enemy_4.png")]
var score_add = 10
var ec1_i = 4
var atk_chance = 0.75

func _ready():
	$Sprite2D.set_texture(texture_array[enemy_choice])
	match enemy_choice:
		0:
			health = 100
			score_add = 25
			atk_chance = 0.75
			$x.speed_scale = 1.0
		1:
			health = 250
			score_add = 50
			atk_chance = 0.75
			$x.speed_scale = 0.8
		2:
			health = 500
			score_add = 100
			atk_chance = 0.66
			$x.speed_scale = 1.0
		3:
			health = 750 
			score_add = 1000
			$x.speed_scale = 1.5
			atk_chance = 0.5
		4:
			health = 2500
			score_add = 10000
			$x.speed_scale = 1.5
			atk_chance = 0.33

	if enemy_choice == 4:
		$Sprite2D.scale = Vector2(1, 1)
	else:
		$Sprite2D.scale = Vector2(0.5, 0.5)
		
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

func enemy_hit():
	match gv.weapon_state:
		0:
			health += -25
		1:
			health += -50
		2: 
			health += -500
	
	$AnimationPlayer.play("reset")
	if health <= 1:
		gv.kills += 1
		gv.score += score_add
		if enemy_choice != 4:
			gv.enemy_chances[enemy_choice] -= 1
		gv.enemy_chances[clampi(enemy_choice + 1, 0, 4)] += 1
		$AnimationPlayer.play("death")
		$x.pause()
		$y.pause()
	else:
		$AnimationPlayer.play("hit")

func _on_timer_timeout():
	if randf() >= atk_chance and can_fire == true and gv.attack_sum and $AnimationPlayer.current_animation != "death":
		match enemy_choice:
			0:
				sound("res://main/sounds/fire_0.wav")
				gv.bullet_type = 0
				fire()
			1:
				ec1_i = 3
				$ec1_timer.start(0.5)
				gv.bullet_type = 1
			2:
				sound("res://main/sounds/fire_2.wav")
				gv.bullet_type = 2
				fire()
			3:
				if randf() >= 0.5:
					ec1_i = 10
					$ec1_timer.start(0.1)
					gv.bullet_type = 3
				else:
					sound("res://main/sounds/fire_3.wav")
					gv.bullet_type = 2
					fire()
			4:
					ec1_i = 10
					$ec1_timer.start(0.1)
					gv.bullet_type = 3

func fire():
	gv.attack_sum = false
	var bullet = load("res://main/bullets/enemy_0_bullet.tscn").instantiate()
	get_node("/root/main").add_child(bullet)
	bullet.position = position
	if gv.bullet_type == 2 or gv.bullet_type == 0:
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

func hit_no_anim():
	health += -10

func nuke():
	health += -500
	enemy_hit()
	
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
