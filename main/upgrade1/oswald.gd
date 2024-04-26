extends Node2D

var remaining_enemies = 30
var possible_targets
var current_target

@onready var audio_sp = $AudioStreamPlayer2D
@onready var label = $Label
@onready var sprite = $Sprite2D

func _physics_process(_delta):
	if gv.upgrade_state[1] == 0:
		gv.upgrade_state[1] = 1
		
func _oswald_enemy_sort(a, b):
	# If the two enemies are of the same tier, then sort by higher health, otherwise sort by higher enemy tier.
	if a.enemy_choice == b.enemy_choice:
		if a.health > b.health:
			return true
		else:
			return false
	else:
		if a.enemy_choice > b.enemy_choice:
			return true
		else:
			return false
	
func _on_timer_timeout():
	if remaining_enemies <= 0:
		queue_free()
	
	# get target enemy
	possible_targets = get_tree().get_nodes_in_group("enemies")
	if possible_targets.size() > 0:
		possible_targets.sort_custom(_oswald_enemy_sort)
		current_target = possible_targets[0]
		
		# "fire"
		sprite.look_at(current_target.position)
		audio_sp.play()
		current_target.enemy_hit(1000, true)
	
		remaining_enemies -= 1
		label.text = str(remaining_enemies)
