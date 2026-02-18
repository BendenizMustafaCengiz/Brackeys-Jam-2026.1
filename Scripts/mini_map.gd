extends Node2D

var map : Map
var room_size := 80
var space := 15

@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect

func generate_minimap() -> void:
	var rooms = map.rooms
	
	var map_image : Image = Image.create(490, 490, false, Image.FORMAT_RGB16)
	map_image.fill(Color.WHITE)
	
	for i in range(rooms.size()):
		for j in range(rooms[i].size()):
			
			var x = space * (i + 1) + room_size * i
			var y = space * (j + 1) + room_size * j
			
			var room_color = Color.BLUE
			if rooms[i][j].visited == true:
				room_color = Color.CORNFLOWER_BLUE
			
			if map.current_room == rooms[i][j]:
				pass
				#icon ayarla
			
			map_image.fill_rect(Rect2i(x, y, room_size, room_size), room_color)
	
	texture_rect.texture = ImageTexture.create_from_image(map_image)


func _ready() -> void:
	map = Save.map
	generate_minimap()


func change_room(dir : String):
	match dir:
		"right":
			map.current_room = map.current_room.right_room
		"left":
			map.current_room = map.current_room.left_room
		"up":
			map.current_room = map.current_room.up_room
		"down":
			map.current_room = map.current_room.down_room
	map.current_room.visited = true
