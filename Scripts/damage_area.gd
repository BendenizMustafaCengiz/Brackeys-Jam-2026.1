extends Area2D

@export var animation_player: AnimationPlayer
var is_player_in : bool = false
var damage: int = 20
var player: Player

func _ready() -> void:
	init()

func init():
	animation_player.play("damage")
	await animation_player.animation_finished
	if is_player_in:
		player.hit(damage)
	animation_player.play("disappear")
	await animation_player.animation_finished
	queue_free()




func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in = true
		if !player:
			player = body


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in = false
