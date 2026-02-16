extends CanvasLayer
class_name SceneManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(scene_path: String)->void:
	animation_player.play("change_scene")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animation_player.play_backwards("change_scene")
