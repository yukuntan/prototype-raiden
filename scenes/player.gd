extends KinematicBody2D

enum Dir {UP, LEFT, DOWN, RIGHT}
const SPEED = 150
const SPEED_ROTATION = 10

onready var sprite = $Sprite

const Weapon = preload("res://scenes/weapon_scatter.tscn")
var weapon = null

func _ready():
	weapon = Weapon.instance()
	weapon.init(Global.weapons[0])
	add_child(weapon)

func _physics_process(delta):
	var dir = Vector2()
	
	if Input.is_action_pressed("left"):
		dir.x += -1
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("up"):
		dir.y += -1
	if Input.is_action_pressed("down"):
		dir.y += 1
		
	if dir.x != 0 or dir.y != 0:
		var angle = dir.angle()
		if angle - rotation > PI:
			angle -= 2 * PI
		rotation = lerp(rotation, angle, SPEED_ROTATION * delta)
		
	move_and_collide(dir.normalized() * SPEED * delta)
	
	if !weapon.is_shooting() and Input.is_action_pressed("shoot"):
		weapon.start()
	
	if Input.is_action_just_released("shoot"):
		weapon.stop()