extends State
class_name PlayerAttack1

@export var sword: Sword
@export var player: Player
@export var animation_player: AnimationPlayer
@export var combo_transition_timer: Timer
var first_tick = false

func enter() -> void:
	sword.attack1()
	combo_transition_timer.start(player.combo_transition_time)
	first_tick = false

func input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click") and first_tick:
		combo_transition_timer.stop()
		transitioned.emit(self,"attack2")


func physics_update(delta : float) -> void:
	var dir: Vector2 = Input.get_vector("left","right","up","down").normalized()
	player.move(dir,delta)
	if player.speed.length() >0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	first_tick = true


func _on_combo_transition_timer_timeout() -> void:
	transitioned.emit(self,"idle")
