extends "res://scenes/weapon.gd"

const BULLET = preload("res://scenes/bullet_laser.tscn")

var bullet = null

func start():
	.start()
	get_bullet().start()

func stop():
	.stop()
	get_bullet().stop()

func get_bullet():
	if null == bullet:
		bullet = BULLET.instance()
		bullet.init(self)
		add_child(bullet)
	return bullet