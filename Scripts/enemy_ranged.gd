extends Enemy

var attack_range: int # range in içine giren olursa ateş et
var wide_range: int # bu range den çıkarsa takip et 
var min_range: int # bu rangein içine girersen geri kaç
var retreat_speed: int 
@onready var shooting_pos: Marker2D = $shooting_pos
const PROJ : PackedScene = preload("res://Scenes/projectile.tscn")

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _ready() -> void:
	HPBar = $StatBar
	attack_area = $AttackArea
	init_stats(Save.rooms_cleared)
	


func init_stats(room_no: int):
	speed = 300
	attack_range = 600
	wide_range = 700
	min_range = 300
	retreat_speed = 450
	damage = 10 + room_no * 3
	attack_area.damage = damage
	health = 100 + room_no * 20
	max_health = health
	knocback_mult = 1.5

func attack(dir: Vector2):
	var new_proj = PROJ.instantiate()
	new_proj.global_position = shooting_pos.global_position
	shooting_pos.add_child(new_proj)
	new_proj.shoot(dir.rotated(randf_range(-PI/10,PI/10)))
