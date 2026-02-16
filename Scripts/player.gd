extends CharacterBody2D
class_name Player

const MAX_SPEED : int = 600
var speed_multiplier : float = 1.0
const ACCEL: float = 40.0
const FRIC : float = 50.0
var speed : Vector2 = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	move_and_slide()
	

func move(dir : Vector2, delta: float)-> void:
	if dir.length() >0:
		speed += ACCEL*dir
	else:
		speed -= FRIC *speed.normalized()
	if speed.length() > MAX_SPEED:
		speed = MAX_SPEED * speed.normalized()
	elif speed.length() < 0:
		speed = Vector2.ZERO
	position += speed*delta
