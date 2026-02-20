extends State
class_name PlayerState

@export var dash_cooldown: Timer
@export var dash_timer: Timer
@export var player: Player
@export var animation_player: AnimationPlayer
@export var sword: Sword
var dash_dir : Vector2

func enter() -> void:
	player.can_dash = false
	dash_timer.start(animation_player.get_animation("dash").length/animation_player.get_playing_speed())
	animation_player.play("dash")
	sword.dash_attack()
	dash_dir = Vector2.RIGHT.rotated(sword.rotation).normalized()

func physics_update(_delta : float) -> void:
	player.position+= dash_dir*player.DASH_SPEED*player.dash_speed_mult
	
func exit() -> void:
	sword.reset_attack()
	


func _on_dash_timer_timeout() -> void:
	dash_cooldown.start(player.dash_cooldown)
	transitioned.emit(self, "idle")
