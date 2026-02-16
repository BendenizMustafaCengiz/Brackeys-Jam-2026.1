class_name Room extends Node2D

#Kaçıncı oda olduğuna göre düşman sayısı belirlenip düşmanlar rastgele patternde spawnlansın

var enemies : Array
var visited : bool
var is_boss_room : bool
var map_pos : Vector2i

#neighbours
var up_room : Room
var down_room : Room
var right_room : Room
var left_room : Room


func _init(x : int, y : int) -> void:
	visited = false
	is_boss_room = false
	enemies = []
	map_pos.x = x
	map_pos.y = y
