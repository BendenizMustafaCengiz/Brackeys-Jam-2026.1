extends Enemy

var player : Player
enum state {ATTACK, ESCAPE, RUN}
var current_state = state.RUN
var inner_attack_range = 400
var outer_attack_range = 1000
var is_attacking = false
var is_in_cooldown = false

@onready var laser: RayCast2D = $Laser
@onready var attack_timer: Timer = $AttackTimer
@onready var laser_sound: AudioStreamPlayer2D = $laser_sound

func _ready() -> void:
	HPBar = $StatBar
	attack_area = $AttackArea
	init_stats(Save.rooms_cleared)
	player = get_tree().get_first_node_in_group("player")
	

func die():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	get_parent().get_parent().check_last_enemy()
	
	laser.enabled = false
	
	speed = 0
	attack_area.disable_mode = CollisionObject2D.DISABLE_MODE_KEEP_ACTIVE
	
	var tween = create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(self, "modulate", Color(0,0,0,0), 0.5)
	tween.tween_property(self, "rotation_degrees", 20, 0.5)
	tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.5)
	
	await tween.finished
	
	queue_free()

func init_stats(rooms_cleared : int) -> void:
	speed = 300
	max_health = rooms_cleared * 5 + 30
	health = max_health
	damage = rooms_cleared + 5
	attack_area.damage = damage
	knocback_mult = 2



func _physics_process(delta: float) -> void:
	
	var dir = player.position - self.position
	
	if dir.length() < inner_attack_range:
		current_state = state.ESCAPE
	elif outer_attack_range > dir.length() and dir.length() > inner_attack_range:
		current_state = state.ATTACK
	else:
		current_state = state.RUN
	
	
	dir = dir.normalized()
	if current_state == state.RUN  and not is_attacking:
		position += speed * dir * delta
		
		if dir.x > 0 : rotation_degrees = -5
		else : rotation_degrees = 5
		
	elif current_state == state.ESCAPE  and not is_attacking:
		position += speed * dir * delta * -1
		
		if dir.x > 0 : rotation_degrees = -5
		else : rotation_degrees = 5
		
	elif current_state == state.ATTACK and not is_attacking and not is_in_cooldown:
		attack()
	
	
	move_and_slide()

func attack() -> void:
	laser_sound.play()
	attack_timer.start()
	is_attacking = true
	is_in_cooldown = true
	
	laser.set_is_casting(true)
	
	var rotation_needed = self.position.angle_to_point(player.position)
	rotation_needed = rad_to_deg(rotation_needed)
	rotation_needed -= 90
	
	var tween = create_tween()
	var plus_minus_one = 2 * randi_range(0,1) - 1
	tween.tween_property(self, "rotation_degrees", rotation_needed + 30 * plus_minus_one, 4.0).from(rotation_needed - 30 * plus_minus_one)
	await tween.finished
	laser_sound.stop()
	is_attacking = false
	laser.set_is_casting(false)
	
	self.rotation = 0.0


func _on_attack_timer_timeout() -> void:
	is_in_cooldown = false
	
