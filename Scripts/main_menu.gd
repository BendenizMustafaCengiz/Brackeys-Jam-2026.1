extends Control

@onready var player: Player = $Player


func _ready() -> void:
	player.health_bar.visible = false
	player.make_static()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_2_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	if Save.played_tutorial:
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
	else:
		ChangeScene.change_scene("res://Scenes/tutorial.tscn")
