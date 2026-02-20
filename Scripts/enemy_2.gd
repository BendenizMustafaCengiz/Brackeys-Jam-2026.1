extends Enemy

var dash_speed : int 
var dash_dist : int = 400
var follow_time : int = 8
var wait_time : int = 2
var dash_limit : int = 700
func _ready() -> void:
	init_stats(Save.rooms_cleared)

func init_stats(room_no: int):
	speed = 250
	dash_speed = 700


func _physics_process(delta: float) -> void:
	move_and_slide()
