extends State
class_name BossFollow

@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player
@export var follow_timer: Timer

func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("move")
	follow_timer.start(randf_range(2,3.5))


func physics_update(delta : float) -> void:
	var dir: Vector2 = (player.global_position - boss.global_position).normalized()
	boss.position += boss.speed * dir *delta
	var dist_to_player : float = (player.global_position - boss.global_position).length()
	if dist_to_player < boss.melee_range:
		transitioned.emit(self,"melee")


func _on_follow_timer_timeout() -> void:
	var dist_to_player : float = (player.global_position - boss.global_position).length()
	if dist_to_player < boss.safe_range:
		transitioned.emit(self,"retreat")
	else:
		random_change_state()

func random_change_state():
	var random_num = randf()
	if random_num > 0.33:
		transitioned.emit(self,"ranged1")
	elif random_num > 0.67:
		transitioned.emit(self,"ranged2")
	else:
		transitioned.emit(self, "summon")
