extends Node2D

var current_wave = 0

var time = 2.00

func _on_wave_pressed():
	if gv.wave_array[0] == true:
		$wave.disabled = true
		current_wave += 1
		if current_wave <= 20:
			time += -0.055
		else:
			time += -0.1
		gv.debug_td = time
		$Timer.start(time)
		gv.wave_array[0] = false
		print(current_wave)
		

func _physics_process(_delta):
	$wave/Label.text = str(current_wave)
	if gv.wave_array[0] == false and $Timer.time_left == 0:
		$Timer.wait_time = randf_range(time, 2)
		$Timer.start()
		if gv.wave_array[current_wave] <= 0:
			gv.wave_array[0] = true
			$wave.disabled = false
			$wave/Label2.text = str(gv.wave_array[current_wave + 1])
		else:
			gv.wave_array[current_wave] -= 1
			$wave/Label2.text = str(gv.wave_array[current_wave] + 1)
			for i in gv.enemy_chances.size():
				if gv.enemy_chances[i] >= randi_range(0, 100) and gv.enemy_chances[i] != 0:
					add_child(preload("res://enemy_0.tscn").instantiate())
					gv.enemy_choice = i
					break
	
func _on_gv_sum_timeout():
	gv.attack_sum = true
