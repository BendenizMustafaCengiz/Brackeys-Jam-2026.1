extends State
class_name Enemy2Follow


@export var follow_timer: Timer
@export var enemy: Enemy
@export var animation_player: AnimationPlayer
var player: Player



func enter() -> void:
	follow_timer.start(randf_range(4,6))
	animation_player.play("follow")
	if ! player:
		player = get_tree().get_first_node_in_group("player")

func physics_update(delta : float) -> void:
	var dir: Vector2 = (player.global_position - enemy.global_position).normalized()
	enemy.position += enemy.speed * dir *delta


func _on_follow_time_timeout() -> void:
	if (player.global_position- enemy.global_position).length() > enemy.dash_limit:
		transitioned.emit(self,"wait")
	else:
		transitioned.emit(self,"dash")
