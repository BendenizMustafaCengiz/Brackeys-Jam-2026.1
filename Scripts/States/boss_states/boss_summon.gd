extends State
class_name BossSummon


@export var enemy1 : PackedScene = preload("res://Scenes/worm.tscn")
@export var enemy2 : PackedScene = preload("res://Scenes/enemy_2.tscn")
@export var enemy3 : PackedScene = preload("res://Scenes/eye_ball.tscn")
@export var enemy4 : PackedScene = preload("res://Scenes/enemy_ranged.tscn")
var available_enemies : Array = [enemy1, enemy2, enemy3, enemy4]
var spawn_sign : PackedScene = preload("res://Scenes/Spawn_Sign.tscn")
@export var summoned_enemies: Node2D

var enemy_set_1: Array = [0,0,1,0,0]
var enemy_set_2: Array = [1,1,1]
var enemy_set_3: Array = [2,2]
var enemy_set_4: Array = [2,3]
var enemy_set_5: Array = [1,3,1]
var enemy_set_6: Array = [1,2,1]
@export var boss: CharacterBody2D
@export var animation_player: AnimationPlayer
var player: Player

func enter() -> void:
	animation_player.play("summon")
	if !player:
		player = get_tree().get_first_node_in_group("player")
	summon_enemies()
	await  animation_player.animation_finished
	random_change_state()

func random_change_state() -> void:
	var random_num = randf()
	if random_num < 0.40:
		transitioned.emit(self,"wait")
	elif random_num < 0.85:
		transitioned.emit(self, "follow")
	else:
		transitioned.emit(self, "retreat")

func summon_enemies():
	var spawn_dir: Vector2 = get_spawn_dir()
	var dist_to_boss : int = 300
	
	var random_num: float = randf()
	var enemy_set: Array
	if random_num < 1.0/6.0:
		enemy_set = enemy_set_1
	elif random_num <2.0/6.0:
		enemy_set = enemy_set_2
	elif random_num < 3.0/6.0:
		enemy_set = enemy_set_3
	elif random_num <4.0/6.0:
		enemy_set = enemy_set_4
	elif random_num < 5.0/6.0:
		enemy_set = enemy_set_5
	else:
		enemy_set = enemy_set_6
	
	for i in enemy_set:
		var new_enemy = available_enemies[i].instantiate()
		var new_sign = spawn_sign.instantiate()
		var spawn_pos_rot = randf_range(-PI/4,PI/4) 
		var spawn_pos: Vector2 = boss.global_position + dist_to_boss*spawn_dir.rotated(spawn_pos_rot)   
		
		new_sign.global_position = spawn_pos
		new_enemy.global_position = spawn_pos
		
		summoned_enemies.add_child(new_sign)
		var tween : Tween = create_tween()
		tween.tween_property(new_sign,"modulate", Color(1,1,1,0), 1.5)
		await tween.finished
		tween.kill()
		new_sign.queue_free()
		summoned_enemies.add_child(new_enemy)

func get_spawn_dir()-> Vector2:
	var dir: Vector2 = Vector2.ZERO
	if boss.global_position.x > 0:
		dir.x = -1
	else:
		dir.x = 1
	if boss.global_position.y > 0:
		dir.y = -1
	else:
		dir.y = 1
	return dir.normalized()
