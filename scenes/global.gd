extends Node
enum {
	TARGET_PLAEYR = 2,
	TARGET_ENEMY = 4
}

var weapons = [{
#
#	weapon
#	
	"delay": 0.7,
	"life": 0.0,
	"cold": 0.3,
	"cold_group": 0.0,
	"shoot_step": 0,
	"count_max": 0,
	"count": 1,
	"angle_center": 0,
	"angle_interval": 15,
	"x_interval": 5,
	"rotate_angle": 5,
	"rotate_angle_max": 15,
	"rotate_flag": 0,
	"origin_x": 0,
	"origin_y": 0,
#
#	bullet
#
	"image": "res://art/shots/1.png",
	"hit_target": TARGET_ENEMY,
	"hit_rect": Vector2(12,7),
	"speed": 300,
	
	"explosion": "res://scenes/explosion_normal.tscn"
}]