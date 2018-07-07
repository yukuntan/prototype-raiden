extends Node2D

signal run_out()

var data = null
var bullets = []
var cold = null
var life = null

var count_available = 0
var count = 0

var shoot_step = 0
var shooting = false
var is_run_out = false

func _ready():
	cold = Timer.new()
	life = Timer.new()
	cold.one_shot = true
	life.one_shot = true
	cold.connect("timeout", self, "_on_cold_finish")
	life.connect("timeout", self, "_on_life_finish")
	add_child(cold)
	add_child(life)

func _on_cold_finish():
	if shoot_step < data.shoot_step:
		cold.set_wait_time(data.cold)
	else:
		cold.set_wait_time(data.cold_group)
		shoot_step = 0
	shoot()
	cold.start()

func _on_life_finish():
	stop()
	run_out()

func init(_data):
	data = _data

func destory():
	for bul in bullets:
		bul.weapon = null
	bullets.clear()
	count_available = 0
	count = 0

func start():
	is_run_out = false
	shooting = true
	shoot_step = 0
	if data.delay > 0:
		cold.set_wait_time(data.delay)
	else:
		shoot()
		cold.set_wait_time(data.cold)
	cold.start()

func stop():
	cold.stop()
	life.stop()
	shooting = false

func shoot():
	shoot_step += 1

func is_shooting():
	return shooting;

func run_out():
	is_run_out = true
	emit_signal("run_out")

func get_bullet():
	if !shooting:
		return null
	
	if data.count_max > 0 and count >= data.count_max:
		run_out()
		return null
	
	for bullet in bullets:
		if !bullet.is_visible():
			bullet.start()
			count_available += 1
			count += 1
			return bullet
	
	var bullet = create_bullet()
	count_available += 1
	count += 1
	bullets.append(bullet)
	return bullet

func remove_bullet(bullet):
	bullet.stop()
	count_available -= 1
	
	if !shooting and count_available <= 0:
		for bul in bullets:
			bul.destroy()
		bullets.clear()
		count = 0

func blast(pos):
	var expl = load(data.explosion).instance()
	expl.set_global_position(pos)
	get_parent().get_parent().add_child(expl)