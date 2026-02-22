class_name Enemy extends CharacterBody2D

var max_health : int
var health : int
var speed : float
var damage : int
var HPBar : Control
var attack_area : Area2D
var knocback_mult: float


func hurt(amount : int, kb_dir: Vector2, kb: float):
	health = health - amount
	
	if health <= 0:
		die()
	
	if HPBar:
		HPBar.update_bar(health, max_health)
	
	#knockback logic
	var final_pos = global_position + kb_dir * kb * knocback_mult
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position", final_pos, 0.2)


func die():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	get_parent().get_parent().check_last_enemy()
	
	speed = 0
	attack_area.disable_mode = CollisionObject2D.DISABLE_MODE_KEEP_ACTIVE
	
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate", Color(0,0,0,0), 0.5)
	tween.tween_property(self, "rotation_degrees", 20, 0.5)
	tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.5)
	
	await tween.finished
	
	queue_free()
	
