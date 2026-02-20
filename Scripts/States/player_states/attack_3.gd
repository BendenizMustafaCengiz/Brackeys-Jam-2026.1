extends State
class_name PlayerAttack3

@export var dash_timer: Timer
@export var player: Player
@export var animation_player: AnimationPlayer
@export var sword: Sword
@export var combo_transition_timer: Timer

func enter() -> void:
	if sword.animation_player.is_animation_active():
		await sword.animation_player.animation_finished
	sword.attack3()
	combo_transition_timer.start(player.combo_transition_time)


func physics_update(delta : float) -> void:
	var dir: Vector2 = Input.get_vector("left","right","up","down").normalized()
	player.move(dir,delta)
	if player.speed.length() >0:
		animation_player.play("run")
	else:
		animation_player.play("idle")

func _on_combo_transition_timer_timeout() -> void:
	transitioned.emit(self,"idle")
