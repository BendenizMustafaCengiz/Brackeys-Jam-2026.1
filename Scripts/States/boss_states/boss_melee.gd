extends State
class_name BossMelee

@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player : Player

func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("melee")
	await animation_player.animation_finished
	boss.melee_damage()
	transitioned.emit(self, "wait")
