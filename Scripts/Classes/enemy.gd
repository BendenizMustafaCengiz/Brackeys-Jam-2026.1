class_name Enemy extends CharacterBody2D

var max_health : int
var health : int
var speed : float
var damage : int

func hurt(amount : int):
	print("ahh bu acıttı")
	health -= amount
