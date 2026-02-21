extends State
class_name EnemyRangedRetreat

@export var enemy: CharacterBody2D
@export var animation_player: AnimationPlayer
var player : Player

var rot_dir: int = 1
var rot_degree: float

func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("RESET")
	animation_player.play("retreat")
	choose_random_rot_dir()

func physics_update(delta : float) -> void:
	var dir = -(player.global_position-enemy.global_position).normalized()
	dir = dir.rotated(rot_dir * rot_degree)
	enemy.position+= dir * enemy.retreat_speed * delta 
	
	var distance_to_player : float = (player.global_position - enemy.global_position).length()
	if distance_to_player > enemy.attack_range:
		transitioned.emit(self, "follow")


func choose_random_rot_dir():
	if randf() > 0.5:
		rot_dir = 1
	else:
		rot_dir = -1
	rot_degree = randf_range(PI/8,PI/4)


func exit() -> void:
	animation_player.play("RESET")
