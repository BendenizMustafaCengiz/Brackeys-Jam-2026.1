extends Area2D

var rarity = "Common"
var amount := 10.0
var description = str("Increase speed by ", amount, "%")
var player : Player
var selected = false

var title_label: Label
var description_label: Label


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	title_label = $TitleLabel
	description_label = $DescriptionLabel

func set_card(rari: String):
	var title_color
	match rari:
		"Common":
			rarity = rari
			amount = 10
			title_color = Color(0.792, 0.793, 0.788, 1.0)
		"Rare":
			rarity = rari
			amount = 20
			title_color = Color(0.133, 0.52, 0.873, 1.0)
		"Epic":
			rarity = rari
			amount = 40
			title_color = Color(0.615, 0.287, 1.0, 1.0)
		
	description = str("Increase speed by ", amount, "%")
	description_label.text = description
	
	title_label.add_theme_color_override("font_color", title_color)
	title_label.text = rarity

func upgrade():
	@warning_ignore("integer_division")
	Stats.cur_max_speed *= (100 + amount) / 100.0

func _on_mouse_entered() -> void:
	selected = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.6, 1.6), 0.2)


func _on_mouse_exited() -> void:
	selected = false
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
