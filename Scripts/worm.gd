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
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	HPBar = $StatBar
	attack_area = $AttackArea
	init_stats(Save.rooms_cleared)

func init_stats(rooms_cleared : int) -> void:
	damage = rooms_cleared * 1 + 5
	speed = 300
	health = rooms_cleared * 5 + 40
	max_health = health
	attack_area.damage = damage
	knocback_mult = 1.5


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
			if animation_player.current_animation != "Move_Right":
				animation_player.play("Move_Right")
		else:
			sprite.flip_h = false
			if animation_player.current_animation != "Move_Left":
				animation_player.play("Move_Left")
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		current_state = state.CHASE
		wait_timer.stop()
		wonder_timer.stop()
		if sprite.flip_h:
			animation_player.play("Move_Right")
		else:
			animation_player.play("Move_Left")
		

func _on_wait_timer_timeout() -> void:
	wonder_timer.start()
	current_state = state.WONDER
	
	#random direction
	wonder_velocity.x = randf_range(-1.0, 1.0)
	wonder_velocity.y = randf_range(-1.0, 1.0)
	wonder_velocity = wonder_velocity.normalized()
	
	if sprite.flip_h:
		animation_player.play("Move_Left")
	else:
		animation_player.play("Move_Right")

func _on_wonder_timer_timeout() -> void:
	wait_timer.start()
	current_state = state.WAIT
	wonder_velocity = Vector2(0,0)
	
	animation_player.play("Idle")
