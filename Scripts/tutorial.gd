extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var canchange = true

var clicks: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canchange:
		if Input.is_action_just_pressed("ui_accept"):
			do_next_thing()

func do_next_thing():
	canchange = false
	if clicks==0:
		animation_player.play("one_to_two")
	elif clicks ==1:
		animation_player.play("two_to_three")
	else:
		ChangeScene.change_scene("res://Scenes/room_scene.tscn")
	clicks +=1


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	canchange = true
