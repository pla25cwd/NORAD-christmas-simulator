extends Control

signal weapon_state_changed

func _ready():
	weapon_state_changed.emit()

func _physics_process(_delta):
	if Input.is_action_just_pressed("debug"):
		if gv.enable_debug_menu:
			$debug.visible = !$debug.visible
			
	$Button/menu.visible = $Button.is_pressed()
	
	var hls_shadow_remap = remap(gv.health, 100, 0, 0, 10)
	$health.text = str(gv.health)
	$health.label_settings.shadow_offset = Vector2(randi_range(-hls_shadow_remap, hls_shadow_remap), randi_range(-hls_shadow_remap, hls_shadow_remap))
	$health.label_settings.shadow_size = hls_shadow_remap
	
	$health.text = str(gv.health)
	$score.text = str(gv.score)
	$actual_score.text = str(gv.actual_score)
	$Button/menu/ProgressBar.value = gv.kills
	
	if gv.score <= 1000 or $Button/menu.visible == false:
		$reset/Button.disabled = true
	elif gv.score >= 1000 and $Button/menu.visible == true:
		$reset/Button.disabled = false

	match gv.weapon_state:
		0:
			$Button/menu/ProgressBar.min_value = 0
			$Button/menu/ProgressBar.max_value = 100
			if gv.kills >= 100:
				gv.weapon_state = 1
				weapon_state_changed.emit()
		1:
			$Button/menu/ProgressBar.min_value = 100
			$Button/menu/ProgressBar.max_value = 600
			if gv.kills >= 600:
				gv.weapon_state = 2
				weapon_state_changed.emit()
		2:
			$Button/menu/ProgressBar.min_value = 600
			$Button/menu/ProgressBar.max_value = 1600
			if gv.kills >= 1600:
				gv.weapon_state = 3
				weapon_state_changed.emit()
		3: 
			$Button/menu/ProgressBar.min_value = 0
			$Button/menu/ProgressBar.max_value = 0


func _on_button_pressed():
	gv.score += -1000
	gv.upgrade_state = [0, 0, 0]
	
func enable_mouse():
	gv.disable_mouse = false
