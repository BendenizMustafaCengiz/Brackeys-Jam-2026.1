extends RayCast2D

@export var cast_speed := 7000.0
@export var max_length := 3000.0
@export var growth_time := 0.1
@export var color := Color.WHITE: set = set_color

@export var is_casting := false: set = set_is_casting

var tween: Tween = null

@onready var line_2d: Line2D = $Line2D
@onready var line_width := line_2d.width


func _ready() -> void:
	
	print('exist')
	set_color(color)
	
	line_2d.points[0] = Vector2.ZERO
	line_2d.points[1] = Vector2.ZERO
	line_2d.visible = false
	
	
	set_is_casting(is_casting)


func _physics_process(delta: float) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		cast_speed * delta
	)

	var laser_end_position := target_position
	force_raycast_update()

	if is_colliding():
		laser_end_position = to_local(get_collision_point())

	line_2d.points[1] = laser_end_position


func set_is_casting(new_value: bool) -> void:
	if is_casting == new_value:
		return
	is_casting = new_value
	set_physics_process(is_casting)
	
	if is_casting:
		line_2d.points[1] = line_2d.points[0]
	
		appear()
	else:
		target_position = Vector2.ZERO
		disappear()

func appear() -> void:
	line_2d.visible = true
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", line_width, growth_time * 2.0).from(0.0)

func disappear() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line_2d, "width", 0.0, growth_time).from_current()
	tween.tween_callback(line_2d.hide)

func set_color(new_color: Color) -> void:
	color = new_color

	if line_2d == null:
		return

	line_2d.modulate = new_color
