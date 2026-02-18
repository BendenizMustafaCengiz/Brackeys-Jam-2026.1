extends Node2D

@onready var player: Player = $Player
@onready var mini_map: Node2D = $MiniMap
@export var worm : PackedScene = preload("res://Scenes/worm.tscn")
var enemies : Array = []
var cleared : bool = false
static var init_player_pos : Vector2 = Vector2(0,0)

func _ready() -> void:
	player.position = init_player_pos
	#zorluk seviyesine göre enemies arrayini doldur

#Right exit
func _on_right_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		mini_map.change_room("right")
		init_player_pos = Vector2(-900,0)
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")

#Left exit
func _on_left_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("left")
		init_player_pos = Vector2(900,0)

#Down exit
func _on_down_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("down")
		init_player_pos = Vector2(0,-900)

#Up exit
func _on_up_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("up")
		init_player_pos = Vector2(0,900)
