class_name Map extends Node2D

var rooms : Array = []
var size = 5
var boss_room_pos : Vector2i
var current_room : Room
var boss_room : Room

func _init() -> void:
	
	#Room init
	for i in range(5):
		rooms.append([])
		for j in range(5):
			rooms[i].append(Room.new(i,j))
	
	init_neighbours()
	
	current_room = rooms[2][2]
	
	
	# choosing boss room
	var die = randi_range(0, 1)
	if die == 1:
		boss_room_pos.y = randi_range(0, 4)
		boss_room_pos.x = 4 * randi_range(0,1)
	elif die == 0:
		boss_room_pos.y = 4 * randi_range(0, 1)
		boss_room_pos.x = randi_range(0, 4)
	boss_room = rooms[boss_room_pos.x][boss_room_pos.y]
	boss_room.is_boss_room = true

func init_neighbours() -> void:
	for i in range(5):
		for j in range(5):
			var cur_room = rooms[i][j]
			
			if i != 0: #left
				cur_room.left_room = rooms[i-1][j]
			
			if j != 0: #up
				cur_room.up_room = rooms[i][j-1]
			
			if i != 4: #right
				cur_room.right_room = rooms[i+1][j]
			
			if j != 4: #down
				cur_room.down_room = rooms[i][j+1]
