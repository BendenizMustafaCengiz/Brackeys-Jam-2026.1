extends State
class_name BossRetreat
@export var disappear_audio: AudioStreamPlayer2D

@export var collision_shape_2d: CollisionShape2D
@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player
const CORNERS : Array[Vector2] = [Vector2(800,800),Vector2(-800,800),
Vector2(800,-800),Vector2(-800,-800)]
const damage_area = preload("res://Scenes/damage_area.tscn")

func enter() -> void:
	disappear_audio.play()
	if !player:
		player = get_tree().get_first_node_in_group("player")
	animation_player.play("disappear")
	collision_shape_2d.disabled = true
	await animation_player.animation_finished
	spawn_damage_area()
	teleport_corner()

func teleport_corner():
	collision_shape_2d.disabled = false
	var corn : Vector2 = get_corner()
	boss.global_position = corn
	animation_player.play_backwards("disappear")
	await animation_player.animation_finished
	random_state_change()

func get_corner()-> Vector2: #player a en uzaktaki köşeyi returnle
	var player_pos: Vector2 = player.global_position
	var largest_dist: float = 0
	var largest_dist_cor: Vector2
	for corner in CORNERS:
		var curr_dist = (player_pos-corner).length()
		if curr_dist > largest_dist:
			largest_dist = curr_dist
			largest_dist_cor = corner
	return largest_dist_cor

func random_state_change():
	var rand_num = randf()
	if rand_num< 0.4:
		transitioned.emit(self,"follow")
	elif  rand_num < 0.7:
		transitioned.emit(self,"ranged1")
	else:
		transitioned.emit(self,"ranged2")


func spawn_damage_area():
	var new_area = damage_area.instantiate()
	new_area.global_position = boss.global_position
	new_area.scale = Vector2(2.5,2.5)
	boss.add_child(new_area)
