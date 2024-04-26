extends Control

var current_wave = 0
var wave_button
var wave_label
var wave_label2
var time = 2.00

func _ready():
	wave_button = get_node("/root/main/ui/wave")
	wave_label = get_node("/root/main/ui/wave/Label")
	wave_label2 = get_node("/root/main/ui/wave/Label2")

func _on_wave_pressed():
	if gv.wave_array[0] == true:
		wave_button.disabled = true
		current_wave += 1
		if current_wave <= 20:
			time += -0.055
		else:
			time += -0.1
		gv.debug_td = time
		$Timer.wait_time = randf_range(time, 2)
		$Timer.start(time)
		gv.wave_array[0] = false
		print(current_wave)
		
func _physics_process(_delta):
	wave_label.text = str(current_wave)
	if gv.wave_array[0] == false and $Timer.time_left == 0:
		$Timer.wait_time = randf_range(time, 2)
		$Timer.start()
		if gv.wave_array[current_wave] <= 0:
			gv.wave_array[0] = true
			wave_button.disabled = false
			wave_label2.text = str(gv.wave_array[current_wave + 1])
		else:
			gv.wave_array[current_wave] -= 1
			wave_label2.text = str(gv.wave_array[current_wave] + 1)
			for i in gv.enemy_chances.size():
				if gv.enemy_chances[i] >= randi_range(0, 100) and gv.enemy_chances[i] != 0:
					add_child(preload("res://enemy_0.tscn").instantiate())
					gv.enemy_choice = i
					break
	
func _on_gv_sum_timeout():
	gv.attack_sum = true
