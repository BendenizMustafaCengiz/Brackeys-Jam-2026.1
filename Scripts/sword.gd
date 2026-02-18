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

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !attacking:
		look_at(get_global_mouse_position())


func attack1():
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash1")
	for enemy in enemiesInAtt1Range:
		enemy.hurt(damage)
	enemiesJustHit.append_array(enemiesInAtt1Range)

func attack2():
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash2")
	for enemy in enemiesInAtt2Range:
		enemy.hurt(damage)
	enemiesJustHit.append_array(enemiesInAtt2Range)

func attack3():
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash3")
	for enemy in enemiesInAtt3Range:
		enemy.hurt(damage)
	enemiesJustHit.append_array(enemiesInAtt2Range)

func _on_slash_area_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt(damage)
		else:
			enemiesInAtt1Range.append(body)


func reset_attack() -> void:
	attacking = false
	enemiesJustHit.clear()
	animation_player.play("RESET")


func _on_slash_area_1_body_exited(body: Node2D) -> void:
	enemiesInAtt1Range.erase(body)
	


func _on_slash_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt(damage)
		else:
			enemiesInAtt1Range.append(body)


func _on_slash_area_2_body_exited(body: Node2D) -> void:
	enemiesInAtt2Range.erase(body)


func _on_slash_area_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			body.hurt(damage)
		else:
			enemiesInAtt1Range.append(body)


func _on_slash_area_3_body_exited(body: Node2D) -> void:
	enemiesInAtt3Range.erase(body)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	reset_attack()
