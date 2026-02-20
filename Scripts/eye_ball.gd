extends Enemy

var player : Player
enum state {ATTACK, ESCAPE, RUN}
var current_state = state.RUN
var inner_attack_range = 400
var outer_attack_range = 1000
var is_attacking = false

func _ready() -> void:
	init_stats(Save.rooms_cleared)
	player = get_tree().get_first_node_in_group("player")


func init_stats(rooms_cleared : int) ->void:
	speed = 300
	max_health = rooms_cleared * 5 + 20
	health = max_health
	damage = rooms_cleared + 5



func _physics_process(delta: float) -> void:
	
	var dir = player.position - self.position
	
	if dir.length() < inner_attack_range and not is_attacking:
		current_state = state.ESCAPE
	elif outer_attack_range > dir.length() and dir.length() > inner_attack_range:
		current_state = state.ATTACK
	else:
		current_state = state.RUN
	
	
	dir = dir.normalized()
	if current_state == state.RUN:
		position += speed * dir * delta
	elif current_state == state.ESCAPE:
		position += speed * dir * delta * -1
	else: #Attack
		pass
		dir = dir.angle_to(player.position)
	
	
	move_and_slide()

func attack() -> void:
	pass
