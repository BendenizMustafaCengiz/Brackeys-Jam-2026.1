class_name UpgradePanel extends CanvasLayer

var max_index = 5
@onready var bg: TextureRect = $BG

@export var damage_up : PackedScene = preload("res://Scenes/damage_upgrade.tscn")
@export var speed_up : PackedScene = preload("res://Scenes/speed_upgrade.tscn")
@export var knockback_up : PackedScene = preload("res://Scenes/knockback_upgrade.tscn")
@export var health_up : PackedScene = preload("res://Scenes/health_upgrade.tscn")
@export var dash_up : PackedScene = preload("res://Scenes/dash_upgrade.tscn")

var op1
var op2
var op3
@onready var op_container: Node2D = $OpContainer

var upgrades := [damage_up, speed_up, knockback_up, health_up, dash_up]
var player : Player

func activate():
	visible = true
	var tween = create_tween()
	tween.tween_property(bg, "modulate", Color(0.288, 0.288, 0.288, 0.733), 1.5)
	await tween.finished
	create_options()
	
func close():
	visible = false
	op_container.remove_child(op1)
	op_container.remove_child(op2)
	op_container.remove_child(op3)

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if Stats.cur_can_dash:
		max_index -= 1

func create_options():
	var index1 = randi_range(0, max_index - 1)
	var option1 = upgrades.get(index1).instantiate()
	option1.global_position = Vector2(460, 700)
	op_container.add_child(option1)
	init_option(option1)
	op1 = option1
	
	var index2 = randi_range(0, max_index - 1)
	while (index2 == index1):
		index2 = randi_range(0, max_index - 1)
	var option2 = upgrades.get(index2).instantiate()
	option2.global_position = Vector2(960, 700)
	op_container.add_child(option2)
	init_option(option2)
	op2 = option2
	
	var index3 = randi_range(0, max_index - 1)
	while (index3 == index1 or index3 == index2):
		index3 = randi_range(0, max_index - 1)
	var option3 = upgrades.get(index3).instantiate()
	option3.global_position = Vector2(1460, 700)
	op_container.add_child(option3)
	init_option(option3)
	op3 = option3


func init_option(option):
	var rand = randf_range(0, 100)
	if rand < 5:
		option.set_card("Epic")
	elif rand < 35:
		option.set_card("Rare")
	else:
		option.set_card("Common")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and op_container.get_child_count() != 0:
		if op1.selected:
			op1.upgrade()
			player.init_stats()
			close()
		elif op2.selected:
			op2.upgrade()
			player.init_stats()
			close()
		elif op3.selected:
			op3.upgrade()
			player.init_stats()
			close()
