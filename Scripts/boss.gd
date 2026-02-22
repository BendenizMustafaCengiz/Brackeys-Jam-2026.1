extends CharacterBody2D

var max_health: int = 1000
var health: int = 1000
var speed: int = 300
var damage: int = 50
const melee_range = 275
const min_wait_range = 240
const safe_range = 500
var is_player_in_melee_range :bool = false
var player : Player
@export var attack_area: Area2D
@onready var stat_bar: StatBar = $CanvasLayer/StatBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	attack_area.damage = 20 #rastgele verdim normalden fazla olsun diye sen kafana göre değiştir
	


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

func hurt(amount : int, _kb_dir: Vector2, _kb: float):
	health = health - amount
	stat_bar.update_bar(health, max_health)
	
	if health <= 0:
		die()
	
func check_last_enemy():
	pass

func die():
	animation_player.play("Die")
	await animation_player.animation_finished
	queue_free()
	ChangeScene.change_scene("res://Scenes/WinScreen.tscn")
