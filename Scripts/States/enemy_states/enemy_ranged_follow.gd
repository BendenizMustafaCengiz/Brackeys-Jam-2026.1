extends State
class_name EnemyRangedFollow


@export var enemy: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player 

func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("RESET")
	animation_player.play("follow")

func physics_update(delta : float) -> void:
	var dir: Vector2 = (player.global_position - enemy.global_position).normalized()
	enemy.position += enemy.speed * dir *delta
	
	var distance_to_player : float = (player.global_position - enemy.global_position).length()
	if distance_to_player < enemy.attack_range:
		transitioned.emit(self, "attack")
