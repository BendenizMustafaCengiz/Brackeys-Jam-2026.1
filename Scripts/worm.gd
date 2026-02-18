extends Enemy

var player : Player
enum state {WONDER, WAIT, CHASE}
var current_state = state.WAIT
var wonder_velocity : Vector2 = Vector2(0, 0)
var wonder_speed = 200
var can_attack = true
var exited_attack_range = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wait_timer: Timer = $WaitTimer
@onready var wonder_timer: Timer = $WonderTimer
@onready var attack_timer: Timer = $AttackTimer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	init_stats(Save.rooms_cleared)

func init_stats(rooms_cleared : int) -> void:
	damage = rooms_cleared * 10 + 50
	speed = 400
	max_health = rooms_cleared * 10 + 500
	max_health = health


func _physics_process(delta: float) -> void:
	#movement
	if current_state == state.WONDER or current_state == state.WAIT:
		position += wonder_speed * wonder_velocity * delta
		if wonder_velocity.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	elif current_state == state.CHASE:
		var direction = player.position - self.position
		direction = direction.normalized()
		position += speed * direction * delta
		if direction.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		current_state = state.CHASE
		wait_timer.stop()
		wonder_timer.stop()
		
		animation_player.play("Move")

func _on_wait_timer_timeout() -> void:
	wonder_timer.start()
	current_state = state.WONDER
	
	#random direction
	wonder_velocity.x = randf_range(-1.0, 1.0)
	wonder_velocity.y = randf_range(-1.0, 1.0)
	wonder_velocity = wonder_velocity.normalized()
	
	animation_player.play("Move")

func _on_wonder_timer_timeout() -> void:
	wait_timer.start()
	current_state = state.WAIT
	wonder_velocity = Vector2(0,0)
	
	animation_player.play("Idle")

func _on_attacking_area_body_entered(body: Node2D) -> void:
	if body is Player and can_attack:
		exited_attack_range = false
		player.hit(damage)
		print('playerr hitted')
		can_attack = false
		attack_timer.start()


func _on_attack_timer_timeout() -> void:
	if not exited_attack_range:
		player.hit(damage)
		attack_timer.start()
		print('player hitted')
	else:
		can_attack = true


func _on_attacking_area_body_exited(body: Node2D) -> void:
	if body is Player:
		exited_attack_range = true
