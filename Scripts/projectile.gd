extends Area2D

var damage: int = 10
var speed: int = 1200
var shooting_dir: Vector2 = Vector2.ZERO
var dist: float = 0.0


func _process(delta: float) -> void:
	if shooting_dir != Vector2.ZERO:
		position += shooting_dir*speed*delta
		dist += speed*delta
		if dist > 2500:
			queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.hit(damage)


func shoot(dir: Vector2):
	shooting_dir = dir
	rotation = Vector2.RIGHT.angle_to(shooting_dir)
