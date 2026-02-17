extends CharacterBody2D
class_name Player

const MAX_SPEED : int = 600
var speed_multiplier : float = 1.0
const ACCEL: int = 70
const FRIC : int = 70
var speed : Vector2 = Vector2.ZERO

@export var combo_transition_time : float = 0.5


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
