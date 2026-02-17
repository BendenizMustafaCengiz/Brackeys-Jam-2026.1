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

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		transitioned.emit(self,"attack1")
