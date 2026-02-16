extends Node2D

var map : Map

var room_size = 50
var space = 10

@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect
@onready var player_icon: Sprite2D = $CanvasLayer/PlayerIcon

func generate_minimap() -> void:
	var rooms = map.rooms
	
	var map_image : Image = Image.create(310, 310, false, Image.FORMAT_RGB16)
	map_image.fill(Color.WHITE)
	
	for i in range(rooms.size()):
		for j in range(rooms[i].size()):
			
			var x = space * (i + 1) + room_size * i
			var y = space * (j + 1) + room_size * j
			
			var room_color = Color.BLUE
			if rooms[i][j].visited == true:
				room_color = Color.CORNFLOWER_BLUE
			
			if map.current_room == rooms[i][j]:
				player_icon.position.x += x
				player_icon.position.y += y
			
			map_image.fill_rect(Rect2i(x, y, room_size, room_size), room_color)
	
	texture_rect.texture = ImageTexture.create_from_image(map_image)


func _ready() -> void:
	map = Map.new()
	generate_minimap()
