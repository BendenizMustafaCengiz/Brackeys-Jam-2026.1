extends State
class_name PlayerAttack3

@export var dash_timer: Timer
@export var player: Player
@export var animation_player: AnimationPlayer
@export var sword: Sword
@export var combo_transition_timer: Timer
var is_dashing: bool = true
var dash_dir: Vector2

func enter() -> void:
	dash_dir = Vector2.RIGHT.rotated(sword.rotation).normalized()
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
	#if is_dashing:
		#player.position+= dash_dir*player.DASH_SPEED*player.dash_speed_mult
	#else:
		#animation_player.play("idle")

func _on_combo_transition_timer_timeout() -> void:
	transitioned.emit(self,"idle")


func _on_dash_timer_timeout() -> void:
	is_dashing = false
