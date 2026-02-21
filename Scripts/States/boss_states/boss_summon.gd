extends State
class_name BossSummon


@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player

func enter() -> void:
	animation_player.play("summon")
	if !player:
		player = get_tree().get_first_node_in_group("player")
	summon_enemies()


func summon_enemies():
	pass
