extends CharacterBody2D
class_name Player

const MAX_SPEED : int = 600
var speed_multiplier : float = 1.0
const ACCEL: int = 70
const FRIC : int = 70
const DASH_SPEED: int = 20
var dash_speed_mult : float = 1
var dash_dist :int = 650
var speed : Vector2 = Vector2.ZERO
var can_dash: bool = true
var dash_cooldown : float = 1

var health := 100
var max_health := 100

@onready var health_bar: StatBar = $CanvasLayer/StatBar

@export var combo_transition_time : float = 0.5
@export var dash_cooldown_timer: Timer


func _physics_process(_delta: float) -> void:
	move_and_slide()

func move(dir : Vector2, delta: float)-> void:
	if dir.length() >0:
		speed += ACCEL*dir
	elif speed.length() > FRIC:
		speed -= FRIC *speed.normalized()
	else:
		speed = Vector2.ZERO
	if speed.length() > MAX_SPEED:
		speed = MAX_SPEED * speed.normalized()
	elif speed.length() <= 0:
		speed = Vector2.ZERO
	position += speed*delta


func hit(amount : int) -> void:
	health = health - amount
	
	if health <= 0:
		print("player died")
		
	health_bar.update_bar(health, max_health)


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
