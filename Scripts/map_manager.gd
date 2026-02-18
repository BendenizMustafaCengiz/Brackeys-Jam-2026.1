class_name MapManager extends Node

var rooms_cleared : int = 0
var map : Map

func _ready() -> void:
	map = Map.new()
