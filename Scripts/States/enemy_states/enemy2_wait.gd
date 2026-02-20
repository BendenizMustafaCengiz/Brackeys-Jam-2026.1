extends State
class_name enemy2Wait

@export var enemy: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var wait_timer: Timer
var player : Player


func enter() -> void:
	wait_timer.start(enemy.wait_time)
	animation_player.play("idle")
	if ! player:
		player = get_tree().get_first_node_in_group("player")


func _on_wait_timer_timeout() -> void:
	transitioned.emit(self, "follow")
