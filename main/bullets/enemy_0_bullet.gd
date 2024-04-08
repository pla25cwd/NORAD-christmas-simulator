extends StaticBody2D

var bullet_type = gv.bullet_type
var bullet_rotation = 0.1
var bullet_speed = 2
var damage = -10
var texture_array = [preload("res://main/bullets/0b.png"), preload("res://main/bullets/1b.png"), preload("res://main/bullets/2b.png"), preload("res://main/bullets/3b.png")]

func _ready():
	$Sprite2D.set_texture(texture_array[bullet_type])
	match bullet_type:
		0:
			bullet_rotation = 0.1
			bullet_speed = 2
			damage = -10
			$CollisionShape2D.shape.radius = 25
		1:
			bullet_rotation = 0.1
			bullet_speed = 1
			damage = -5
			$CollisionShape2D.shape.radius = 30
		2:
			bullet_rotation = 0
			bullet_speed = 5
			damage = -20
			$CollisionShape2D.shape.radius = 50
		3:
			bullet_rotation = 0
			bullet_speed = 10
			damage = -10
			$CollisionShape2D.shape.radius = 40

func _physics_process(_delta):
	if $AnimationPlayer.current_animation != "hit":
		translate(Vector2(bullet_speed, 0).rotated(rotation))
		$Sprite2D.rotation += bullet_rotation

func enemy_hit():
	$AnimationPlayer.play("hit")
	gv.score += 5
	gv.kills += 0.5
	
func _on_timer_timeout():
	queue_free()

func bullet_hit():
	gv.health += damage
	$AnimationPlayer.play("hit")
	

func freeze_ray_0():
	enemy_hit()
	
func freeze_ray_1():
	enemy_hit()

func nuke():
	enemy_hit()
