class_name PlayerStats extends Node

const init_damage := 20
const init_max_health := 150
const init_max_speed := 600
const init_knockback_mult := 500
const init_can_dash = false

var cur_damage := 20
var cur_max_health := 150
var cur_max_speed := 600
var cur_knockback_mult := 1.0
var cur_can_dash := false

func reset()-> void:
	cur_damage = init_damage
	cur_can_dash = init_can_dash
	cur_max_speed = init_max_speed
	cur_max_health = init_max_speed
	cur_knockback_mult = init_knockback_mult
