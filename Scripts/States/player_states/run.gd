extends State
class_name PlayerRun

@export var player: Player
@export var animation_player: AnimationPlayer

func enter() -> void:
	animation_player.play("RESET")
	animation_player.play("run")

func physics_update(delta : float) -> void:
	if !(Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		transitioned.emit(self, "idle")
	var dir: Vector2 = Input.get_vector("left","right","up","down").normalized()
	player.move(dir,delta)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		transitioned.emit(self,"attack1")
