extends Enemy

const melee_range = 275
const min_wait_range = 250
const safe_range = 500
var is_player_in_melee_range :bool = false
var player : Player

func _ready() -> void:
	inint_stats(Save.rooms_cleared)


func inint_stats(_room_no: int):
	speed = 300
	damage = 100
	health = 5000
	max_health = health


func _physics_process(_delta: float) -> void:
	move_and_slide()

func melee_damage():
	if! is_player_in_melee_range:
		return
	
	player.hit(damage)
	var dir_to_player = (player.global_position - global_position).normalized()
	player.knockback(dir_to_player)

func _on_melee_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_in_melee_range = true
		if !player:
			player = body


func _on_melee_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_in_melee_range = false
