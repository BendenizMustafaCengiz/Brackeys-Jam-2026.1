extends CharacterBody2D
class_name Player

var max_speed : int = 600
var speed_multiplier : float = 1.0
const ACCEL: int = 70
const FRIC : int = 70
const DASH_SPEED: int = 20
var dash_speed_mult : float = 1
var dash_dist :int = 650
var speed : Vector2 = Vector2.ZERO
var can_dash: bool = true
var dash_cooldown : float = 1
var knockback_mult: float = 500

var health := 100
var max_health := 100

@onready var health_bar: StatBar = $CanvasLayer/StatBar
@onready var sword: Sword = $Sword

@export var combo_transition_time : float = 0.5
@export var dash_cooldown_timer: Timer

func init_stats():
	max_speed = Stats.cur_max_speed
	sword.damage = Stats.cur_damage
	max_health = Stats.cur_max_health
	knockback_mult = Stats.cur_knockback_mult
	can_dash = Stats.cur_can_dash
	print(max_speed, "  ", sword.damage)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func move(dir : Vector2, delta: float)-> void:
	if dir.length() >0:
		speed += ACCEL*dir
	elif speed.length() > FRIC:
		speed -= FRIC *speed.normalized()
	else:
		speed = Vector2.ZERO
	if speed.length() > max_speed:
		speed = max_speed * speed.normalized()
	elif speed.length() <= 0:
		speed = Vector2.ZERO
	position += speed*delta


func hit(amount : int) -> void:
	health = health - amount
	
	if health <= 0:
		die()
		
	health_bar.update_bar(health, max_health)

func die():
	get_parent().game_over()

func knockback(dir : Vector2):
	var tween: Tween = create_tween()
	var final_pos = position+ dir*knockback_mult
	tween.tween_property(self,"position",final_pos,0.3)
	

func _on_dash_cooldown_timeout() -> void:
	can_dash = true
