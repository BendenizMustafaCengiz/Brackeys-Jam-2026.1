extends Area2D

var rarity = "Epic"
var amount = true
var description = str("Unlock dash ability ('Shift' or 'Right Click' to dash)")
var player : Player
var selected = false

var title_label: Label
var description_label: Label


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	title_label = $TitleLabel
	description_label = $DescriptionLabel

func set_card(_rari):
	var title_color
	rarity = "Epic"
	amount = true
	title_color = Color(0.615, 0.287, 1.0, 1.0)
	
	description = str("Unlock dash ability ('Shift' or 'Right Click' to dash)")
	description_label.text = description
	
	title_label.add_theme_color_override("font_color", title_color)
	title_label.text = rarity

func upgrade():
	Stats.cur_can_dash = true

func _on_mouse_entered() -> void:
	selected = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.6, 1.6), 0.2)

func _on_mouse_exited() -> void:
	selected = false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
