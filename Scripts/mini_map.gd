extends Node2D

var map : Map
var room_size := 80
var space := 15

var mini_size = Vector2(0.5,0.5)
var big_size = Vector2(1.5,1.5)
var mini_pos = Vector2(1592.0, 760.0)
var big_pos = Vector2(568, 152)

var is_mini = true

@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect
@onready var step_label: Label = $CanvasLayer/StepLabel

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_map"):
		if is_mini:
			texture_rect.scale = big_size
			texture_rect.position = big_pos
		else:
			texture_rect.scale = mini_size
			texture_rect.position = mini_pos
		is_mini = not is_mini
	

func generate_minimap() -> void:
	var rooms = map.rooms
	
	var map_image : Image = Image.create(490, 490, false, Image.FORMAT_RGB16)
	map_image.fill(Color.WHITE)
	
	for i in range(rooms.size()):
		for j in range(rooms[i].size()):
			
			var x = space * (i + 1) + room_size * i
			var y = space * (j + 1) + room_size * j
			
			var room_color = Color.DIM_GRAY
			if rooms[i][j].visited == true or rooms[i][j] == map.current_room:
				room_color = Color.DEEP_SKY_BLUE
			
			map_image.fill_rect(Rect2i(x, y, room_size, room_size), room_color)
			
			if map.current_room == rooms[i][j]:
				room_color = Color.DARK_RED
				@warning_ignore("integer_division")
				map_image.fill_rect(Rect2i(x + room_size/4, y + 2 * room_size / 5 , room_size / 2, room_size / 5), room_color)
				@warning_ignore("integer_division")
				map_image.fill_rect(Rect2i(x + 2 * room_size / 5, y+room_size / 4 , room_size / 5, room_size / 2), room_color)
	
	texture_rect.texture = ImageTexture.create_from_image(map_image)
	step_label.text = str("steps left: ", (10 - Save.rooms_cleared))


func _ready() -> void:
	map = Save.map
	generate_minimap()


func change_room(dir : String):
	map.current_room.visited = true
	match dir:
		"right":
			map.current_room = map.current_room.right_room
		"left":
			map.current_room = map.current_room.left_room
		"up":
			map.current_room = map.current_room.up_room
		"down":
			map.current_room = map.current_room.down_room
	if map.current_room.visited == false:
		Save.rooms_cleared += 1
