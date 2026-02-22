extends Node2D

@onready var player: Player = $Player
@onready var mini_map: Node2D = $MiniMap
var room : Room

@export var enemy1 : PackedScene = preload("res://Scenes/worm.tscn")
@export var enemy2 : PackedScene = preload("res://Scenes/enemy_2.tscn")
@export var enemy3 : PackedScene = preload("res://Scenes/eye_ball.tscn")
@export var enemy4 : PackedScene = preload("res://Scenes/enemy_ranged.tscn")
var avaliable_enemies : Array = [enemy1, enemy2, enemy3, enemy4]
var enemies : Array = []
var total_enemies = 0
var enemies_killed = 0
@onready var enemies_node: Node2D = $EnemiesNode

@onready var spawn_timer: Timer = $SpawnTimer

var spawn_sign : PackedScene = preload("res://Scenes/Spawn_Sign.tscn")
@onready var signs: Node2D = $Signs

var cleared : bool = false
static var init_player_pos : Vector2 = Vector2(0,0)

@onready var doors: StaticBody2D = $Doors

@onready var die_screen: Node2D = $DieScreen
@onready var upgrade_panel: UpgradePanel = $UpgradePanel


func _ready() -> void:
	player.position = init_player_pos
	player.init_stats()
	create_enemies(Save.rooms_cleared)
	room = mini_map.map.current_room
	print(room.map_pos)
	if not room.visited:
		spawn_timer.start()
	else:
		open_doors()

func check_last_enemy()-> void:
	enemies_killed += 1
	print('total enemies ', total_enemies, '  enemies killed: ', enemies_killed)
	if enemies_killed == total_enemies:
		spawn_timer.paused = true
		open_doors()
		upgrade_panel.activate()
		room.visited = true

func create_enemies(rooms_cleared: int) -> void:
	enemies.clear()
	var enemy_count = 1 + rooms_cleared
	total_enemies = enemy_count
	
	for i in range(enemy_count):
		var dice = randf_range(0,100)
		if dice < 60 - rooms_cleared * 5:
			enemies.append(1)
		elif dice < 80 - rooms_cleared * 5:
			enemies.append(2)
		elif dice < 100 - rooms_cleared * 3:
			enemies.append(3)
		else:
			enemies.append(4)

func random_enemy_pos() -> Vector2:
	var n = randi_range(0,1)
	var random_x = 750
	var random_y = 750
	
	if n == 1:
		random_x = (2 * randi_range(0,1) - 1) * randf_range(500,900)
		random_y = randf_range(-900, 900)
	else:
		random_x = randf_range(-900, 900)
		random_y = (2 * randi_range(0,1) - 1) * randf_range(500,900)
	
	return Vector2(random_x, random_y)

func summon_enemies(count : int) -> void:
	if enemies.size() < count:
		count = enemies.size()
	
	for i in range(count):
		var rand_pos = random_enemy_pos()
		
		var new_sign = spawn_sign.instantiate()
		new_sign.global_position = rand_pos
		signs.add_child(new_sign)
		
		handle_summon(new_sign)

func handle_summon(spawn_s):
	
	var enemy
	
	var enemy_type = enemies.pop_front()
	
	if enemy_type == 1:
		enemy = enemy1.instantiate()
	elif enemy_type == 2:
		enemy = enemy2.instantiate()
	elif enemy_type == 3:
		enemy = enemy3.instantiate()
	else:
		enemy = enemy4.instantiate()
	
	enemy.global_position = spawn_s.global_position
	
	var tween = create_tween()
	tween.tween_property(spawn_s, "modulate", Color(1,1,1,0), 1.5)
	await tween.finished
	spawn_s.queue_free()
	
	enemies_node.add_child(enemy)

func _process(_delta: float) -> void:
	pass

#Right exit
func _on_right_exit_body_entered(body: Node2D) -> void:
	if room.right_room == null:
		return
	if body.name == "Player":
		mini_map.change_room("right")
		init_player_pos = Vector2(-900,0)
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")

#Left exit
func _on_left_exit_body_entered(body: Node2D) -> void:
	if room.left_room == null:
		return
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("left")
		init_player_pos = Vector2(900,0)

#Down exit
func _on_down_exit_body_entered(body: Node2D) -> void:
	if room.down_room == null:
		return
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("down")
		init_player_pos = Vector2(0,-900)

#Up exit
func _on_up_exit_body_entered(body: Node2D) -> void:
	if room.up_room == null:
		return
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("up")
		init_player_pos = Vector2(0,900)

func game_over():
	die_screen.activate()

func open_doors() -> void:
	print("doors opening")
	
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(doors, "modulate", Color(0,0,0,0), 1)
	doors.collision_layer = 4

func _on_spawn_timer_timeout() -> void:
	
	var count := randi_range(3, 6)
	summon_enemies(count)
	
	spawn_timer.wait_time = randf_range(5, 10)
	spawn_timer.start()
