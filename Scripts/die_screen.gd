extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer

@onready var game_over_text: RichTextLabel = $CanvasLayer/GameOverText
@onready var bg: TextureRect = $CanvasLayer/BG

func activate() -> void:
	canvas_layer.visible = true
	var tween = create_tween()
	tween.tween_property(bg,"modulate", Color(0.0, 0.0, 0.0, 0.588), 2.0)

func _on_try_again_button_pressed() -> void:
	#Zorluk ve map reseti vs vs.
	ChangeScene.change_scene("res://Scenes/room_scene.tscn")

func _on_main_menu_button_pressed() -> void:
	#Zorluk ve map reseti vs vs.
	ChangeScene.change_scene("res://Scenes/main_menu.tscn")
