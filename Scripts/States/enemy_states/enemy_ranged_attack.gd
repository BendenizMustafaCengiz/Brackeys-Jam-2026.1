extends State
class_name EnemyRangedAttack

@export var random_movement_timer: Timer
@export var enemy: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var attack_timer: Timer
var rot_dir: int = 1
var rot_degree: float
var dir_to_player :Vector2 

var player : Player 
func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	choose_random_rot_dir()
	animation_player.play("RESET")
	animation_player.play("attack")
	attack_timer.start(0.7)
	random_movement_timer.start(randf_range(1,3))

func physics_update(delta : float) -> void:
	var distance_to_player : float = (player.global_position - enemy.global_position).length()
	if distance_to_player > enemy.wide_range:
		transitioned.emit(self, "follow")
	elif distance_to_player < enemy.min_range:
		transitioned.emit(self,"retreat")
		
		
	dir_to_player = (player.global_position-enemy.global_position).normalized()
	var dir: Vector2 = dir_to_player.rotated(deg_to_rad(rot_degree))
	enemy.position+= dir * enemy.speed * delta * rot_dir

func exit() -> void:
	attack_timer.stop()
	animation_player.play("RESET")


func _on_random_movement_timer_timeout() -> void:
	choose_random_rot_dir()
	random_movement_timer.start(randf_range(1,3))

func choose_random_rot_dir():
	if randf() > 0.5:
		rot_dir = 1
	else:
		rot_dir = -1
	rot_degree = randf_range(80,100)


func _on_attack_timer_timeout() -> void:
	attack_timer.start(1)
	enemy.attack(dir_to_player)
