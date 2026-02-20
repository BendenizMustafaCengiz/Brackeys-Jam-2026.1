extends State
class_name Enemy2Dash

@export var enemy: Enemy
@export var animation_player: AnimationPlayer
var player: Player
var dash_dir: Vector2  
var curr_dash_dist : float = 0

func enter() -> void:
	if ! player:
		player = get_tree().get_first_node_in_group("player")
	dash_dir = (player.global_position - enemy.global_position).normalized()
	if randf() > 0.5: 
		dash_dir = dash_dir.rotated(PI/3)
	else:
		dash_dir = dash_dir.rotated(-PI/3)
	curr_dash_dist = 0
	animation_player.play("dash_prep")
	await animation_player.animation_finished
	animation_player.play("dash")
	
	dash_dir = (player.global_position - enemy.global_position).normalized()
	dash_dir = dash_dir.rotated(randf_range(-PI/6,PI/6))

func physics_update(delta : float) -> void:
	enemy.position += dash_dir*enemy.dash_speed * delta
	curr_dash_dist += enemy.speed *delta
	if curr_dash_dist > enemy.dash_dist:
		transitioned.emit(self,"follow")
