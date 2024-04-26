extends ItemList

var h_enabled = false
var s_enabled = false

func _physics_process(_delta):
	if h_enabled == true:
		gv.health = 100
	
	set_item_text(0, "debug_ec = " + str(gv.enemy_chances))
	set_item_text(1, "debug_td = " + str(gv.debug_td))
	set_item_text(2, "debug_pt = " + str(gv.debug_pt))
	set_item_text(3, "cheat_h = " + str(h_enabled))
	set_item_text(4, "cheat_s = " + str(s_enabled))
	#set_item_text(5, "debug1_bullet_type = " + str(gv.bullet_type))
	set_item_text(5, "debug1_enemy_choice = " + str(gv.enemy_choice))
	
func _ready():
	visible = false

func _on_item_activated(index):
	match index:
		3:
			h_enabled = !h_enabled
			
		4:
			if s_enabled == false:
				gv.score += 1000000000
				s_enabled = true
			elif s_enabled == true:
				gv.score = maxi(gv.score - 1000000000, 0)
				s_enabled = false
