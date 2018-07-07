extends "res://scenes/weapon.gd"

const BULLET = preload("res://scenes/bullet_common.tscn")

var shoot_add_flag = 0
var shoot_count = 0
var distance = 0

func start():
	.start()
	shoot_add_flag = 1

func stop():
	.stop()
	shoot_add_flag = 0
	shoot_count = 0
	distance = 0

func shoot():
	.shoot()
	shoot_count += shoot_add_flag;
	var start_angle = 0.0
	var start_x = 0.0
	if data.count % 2 == 0:
		start_angle = data.angle_interval / 2 + (data.count / 2 - 1) * data.angle_interval
		start_x = -1 * (data.x_interval / 2 + (data.count / 2 - 1) * data.x_interval)
	else:
		start_angle = (data.count - 1) / 2 * data.angle_interval
		start_x = -1 * (data.count - 1) / 2 * data.x_interval
	
	var p_cos = cos(deg2rad(data.angle_center))
	var p_sin = sin(deg2rad(data.angle_center))
	
	for i in range(data.count):
		var angle = start_angle - data.angle_interval * i
		var dist = start_x + data.x_interval * i
		var x = dist * p_cos
		var y = -dist * p_sin
		var offset = Vector2(data.origin_x + x, data.origin_y + y)
		if !add_bullet(offset, angle):
			break

func add_bullet(offset, offset_angle):
	var bullet = get_bullet()
	if !bullet:
		return false
		
	var pos = Vector2(0,0)
	var rot = deg2rad(get_center_line_angle(bullet, pos) + offset_angle)
	if data.count > 1:
		if data.angle_center > 0 and data.angle_center < 180:
			pos.x += offset.x
			pos.y += offset.y
		else:
			pos.x -= offset.x
			pos.y -= offset.y
	
	pos += get_parent().get_position()
	rot += get_parent().get_rotation()
	bullet.set_position(pos)
	bullet.set_rotation(rot)
	bullet.start()

func get_center_line_angle(bullet, pos):
	var angle = (shoot_count - 1) * data.rotate_angle
	if abs(angle) > data.rotate_angle_max and data.rotate_angle_max >= 1:
		if data.rotate_flag == 0:
			if angle * data.rotate_angle > 0:
				shoot_add_flag = -1
			else:
				shoot_add_flag = 1
		else:
			shoot_count = 0
			shoot_add_flag = 1
	return data.angle_center + angle

func create_bullet():
	var bullet = BULLET.instance()
	bullet.init(self)
	get_parent().get_parent().add_child(bullet)
	return bullet