extends Sprite2D

func dissapear():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1.5)
	await tween.finished
	queue_free()
