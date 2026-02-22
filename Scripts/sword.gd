extends Marker2D
class_name Sword

var damage : int = 20
var dash_dmg: int = 30
var final_dmg: int = 30
const ATT1KB: int = 20
const ATT2KB: int = 20
const ATT3KB: int = 50
var kb_mult: float = 1.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var attacking: bool = false
@onready var sprite: Sprite2D = $Sprite2D

var enemiesJustHit : Array = []
var enemiesInAtt1Range: Array = []
var enemiesInAtt2Range: Array = []
var enemiesInAtt3Range: Array = []
var enemiesInDashRange: Array = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !attacking:
		look_at(get_global_mouse_position())


func attack1():
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash1")
	for enemy in enemiesInAtt1Range:
		if enemiesJustHit.has(enemy):
			continue
		hit_enemy(enemy,damage,ATT1KB)
	
func attack2():
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash2")
	for enemy in enemiesInAtt2Range:
		if enemiesJustHit.has(enemy):
			continue
		hit_enemy(enemy,damage,ATT2KB)

func attack3():
	if animation_player.is_animation_active():
		await animation_player.animation_finished
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("slash3")
	for enemy in enemiesInAtt3Range:
		if enemiesJustHit.has(enemy):
			continue
		hit_enemy(enemy, final_dmg, ATT3KB)

func dash_attack():
	enemiesJustHit.clear()
	attacking = true
	animation_player.play("dash")
	for enemy in enemiesInDashRange:
		if enemiesJustHit.has(enemy):
			continue
		hit_enemy(enemy, dash_dmg, ATT3KB)
	

func _on_slash_area_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			hit_enemy(body, damage, ATT1KB)
		else:
			if ! enemiesInAtt1Range.has(body):
				enemiesInAtt1Range.append(body)



func reset_attack() -> void:
	attacking = false
	enemiesJustHit.clear()
	animation_player.play("RESET")


func _on_slash_area_1_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	enemiesInAtt1Range.erase(body)


func _on_slash_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			hit_enemy(body, damage, ATT2KB)
		else:
			if ! enemiesInAtt2Range.has(body):
				enemiesInAtt2Range.append(body)


func _on_slash_area_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	enemiesInAtt2Range.erase(body)


func _on_slash_area_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			hit_enemy(body, final_dmg, ATT3KB)
		else:
			if ! enemiesInAtt3Range.has(body):
				enemiesInAtt3Range.append(body)


func _on_slash_area_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	enemiesInAtt3Range.erase(body)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	reset_attack()


func _on_dash_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body.is_class("CharacterBody2D"): # class ı enemy olarak değiştir
		if attacking and !enemiesJustHit.has(body):
			hit_enemy(body, dash_dmg, ATT3KB)
		else:
			if ! enemiesInDashRange.has(body):
				enemiesInDashRange.append(body)


func _on_dash_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	enemiesInDashRange.erase(body)


func hit_enemy(enemy: CharacterBody2D,dmg: int, kb: int):
	var hit_dir: Vector2 = Vector2.RIGHT.rotated(rotation) 
	enemy.hurt(dmg, hit_dir, kb * kb_mult)
	enemiesJustHit.append(enemy)
