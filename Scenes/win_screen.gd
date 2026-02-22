extends Node2D

@onready var player_2: Player = $Player2


func _ready() -> void:
	player_2.make_static()


func _on_play_button_pressed() -> void:
	Save.reset()
	Stats.reset()
	ChangeScene.change_scene("res://Scenes/main_menu.tscn")
