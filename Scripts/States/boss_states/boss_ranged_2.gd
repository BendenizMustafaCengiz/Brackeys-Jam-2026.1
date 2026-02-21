extends State

class_name BossRanged2

@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var attack_timer: Timer
var player: Player 
const DAMAGE_AREA = preload("res://Scenes/damage_area.tscn")


func enter() -> void:
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("ranged")
	attack()

func attack():
	var num_of_areas:int = 10
	var rel_area_pos_to_plyr : Vector2 = Vector2(0,150)
	for i in range(num_of_areas):
		var player_pos : Vector2 = player.global_position
		rel_area_pos_to_plyr = rel_area_pos_to_plyr.rotated(randf_range(0,2*PI))
		var new_area = DAMAGE_AREA.instantiate()
		new_area.global_position = player_pos+rel_area_pos_to_plyr
		new_area.scale = Vector2(1.5,1.5)
		boss.add_child(new_area)
		
		await get_tree().create_timer(0.4).timeout 
	random_state_change()



func random_state_change():
	var rand_num = randf()
	if rand_num< 0.75:
		transitioned.emit(self,"follow")
	else:
		transitioned.emit(self,"follow")
