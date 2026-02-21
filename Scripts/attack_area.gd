extends Area2D

var can_attack = true
var player_is_in_area = false
var damage = 10
var player : Player
@onready var attack_timer: Timer = $AttackTimer

func _on_body_entered(body: Node2D) -> void:
	
	if body is Player:
		
		if player == null:
			player = body
		
		if can_attack:
			player.hit(damage)
			print("player hitted", damage)
			can_attack = false
			
		player_is_in_area = true
		attack_timer.start()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_is_in_area = false


func _on_attack_timer_timeout() -> void:
	if player_is_in_area and player:
		player.hit(damage)
		print("player hitted ", damage)
	else:
		can_attack = true
