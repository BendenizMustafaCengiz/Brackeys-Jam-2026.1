extends Marker2D
class_name Sword

var damage: int
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var attacking: bool = false
@onready var sprite: Sprite2D = $Sprite2D

var enemiesJustHit : Array = []
var enemiesInAtt1Range: Array = []
var enemiesInAtt2Range: Array = []
var enemiesInAtt3Range: Array = []


@onready var combo_cooldown_timer: Timer = $comboCooldown #combo yu bitirdikten sonra yeni comboya hemen başlamamsı için
@onready var combo_cont_timer: Timer = $combo_cont_timer # ataklar arasında combonun devam edebilmesi için olan süre
@export var combo_cont_time: float = 0

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !attacking:
		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("ui_accept"):
			attack1()
		


func attack1():
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash1")
	for enemy in enemiesInAtt1Range:
		enemy.hurt()
	enemiesJustHit.append_array(enemiesInAtt1Range)
	combo_cont_timer.start(combo_cont_time)

func attack2():
	enemiesJustHit.clear()
	attacking = true
	combo_cont_timer.stop()
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	animation_player.play("slash2")
	for enemy in enemiesInAtt2Range:
		enemy.hurt()
	enemiesJustHit.append_array(enemiesInAtt2Range)
	combo_cont_timer.start(combo_cont_time)

func attack3():
	enemiesJustHit.clear()
	attacking = true
	combo_cont_timer.stop()
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	animation_player.play("slash3")
	for enemy in enemiesInAtt3Range:
		enemy.hurt()
	enemiesJustHit.append_array(enemiesInAtt2Range)
	combo_cont_timer.start(combo_cont_time)

func _on_slash_area_1_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt()
		else:
			enemiesInAtt1Range.append(body)


func _on_combo_cont_timer_timeout() -> void:
	reset_attack()

func reset_attack() -> void:
	attacking = false
	enemiesJustHit.clear()
	animation_player.play("RESET")


func _on_slash_area_1_body_exited(body: Node2D) -> void:
	enemiesInAtt1Range.erase(body)


func _on_slash_area_2_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt()
		else:
			enemiesInAtt2Range.append(body)


func _on_slash_area_2_body_exited(body: Node2D) -> void:
	enemiesInAtt2Range.erase(body)


func _on_slash_area_3_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt()
		else:
			enemiesInAtt3Range.append(body)


func _on_slash_area_3_body_exited(body: Node2D) -> void:
	enemiesInAtt3Range.erase(body)
