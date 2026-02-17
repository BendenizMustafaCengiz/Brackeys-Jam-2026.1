extends Node2D

@onready var mini_map: Node2D = $MiniMap
@export var worm : PackedScene = preload("res://Scenes/worm.tscn")
var enemies : Array = []

func _ready() -> void:
	pass
	#zorluk seviyesine göre enemies arrayini doldur

func _on_right_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
		mini_map.change_room("right")
		#düşmanlar oluşacak
		#player konumu
