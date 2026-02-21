extends Area2D

var damage: int
var speed: int = 800
var shooting_dir: Vector2 = Vector2.ZERO
var dist: float = 0.0
var random_rot : float
var random_rot_dir: int 

func _ready() -> void:
	damage = 10 + Save.rooms_cleared * 3

func _process(delta: float) -> void:
	if shooting_dir != Vector2.ZERO:
		position += shooting_dir*speed*delta
		dist += speed*delta
		if dist > 2500:
			queue_free()
		rotation+= random_rot*random_rot_dir*delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.hit(damage)
		queue_free()

func shoot(dir: Vector2):
	shooting_dir = dir
	rotation = Vector2.RIGHT.angle_to(shooting_dir)
	if randf() > 0.5:
		random_rot_dir = 1
	else:
		random_rot_dir = -1
	random_rot = randf_range(5,20)
