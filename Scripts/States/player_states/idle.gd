extends State
class_name PlayerIdle

@export var player: Player
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("RESET")
	animation_player.play("idle")


func update(_delta : float) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
		transitioned.emit(self, "run")

func physics_update(delta : float) -> void:
	player.move(Vector2.ZERO, delta)
