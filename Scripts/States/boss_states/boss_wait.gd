extends State
class_name  BossWait

@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var wait_timer: Timer
var player: Player
var rot_dir: int = 1
var rot_degree: float
var dir_to_player :Vector2 


func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("move")
	var rand_wait_time: float = randf_range(3,5)
	wait_timer.start(rand_wait_time)
	choose_random_rot_dir()

func physics_update(delta : float) -> void:
	dir_to_player = (player.global_position-boss.global_position).normalized()
	var dir: Vector2 = dir_to_player.rotated(deg_to_rad(rot_degree))
	boss.position+= dir * boss.speed * delta * rot_dir
	
	var distance_to_player : float = (player.global_position - boss.global_position).length()
	if distance_to_player < boss.min_wait_range:
		transitioned.emit(self, "retreat")


func _on_wait_timer_timeout() -> void:
	random_change_state()

func random_change_state() -> void:
	var rand_num = randf()
	if rand_num <0.4:
		transitioned.emit(self,"summon")
	elif rand_num < 0.7:
		transitioned.emit(self,"ranged1")
	else:
		transitioned.emit(self,"ranged2")

func choose_random_rot_dir():
	if randf() > 0.5:
		rot_dir = 1
	else:
		rot_dir = -1
	rot_degree = randf_range(100,120)
