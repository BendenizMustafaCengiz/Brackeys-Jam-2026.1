extends State
class_name BossRanged1

@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player
const DAMAGE_AREA = preload("res://Scenes/damage_area.tscn")

func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("ranged")
	attack()

func attack():
	var num_of_areas:int = 8
	var rel_area_pos_to_plyr : Vector2 = Vector2(0,-300)
	for i in range(num_of_areas):
		var player_pos : Vector2 = player.global_position
		var new_area = DAMAGE_AREA.instantiate()
		new_area.global_position = player_pos+rel_area_pos_to_plyr
		rel_area_pos_to_plyr = rel_area_pos_to_plyr.rotated(2*PI/num_of_areas)
		add_child(new_area)
		await get_tree().create_timer(0.15).timeout 
	random_state_change()
	

func random_state_change():
	var rand_num = randf()
	if rand_num< 0.75:
		transitioned.emit(self,"follow")
	else:
		transitioned.emit(self,"follow")
