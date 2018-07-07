extends Node2D

var weapon = null

onready var RANGE_RAY = get_viewport().get_visible_rect().size.length()
onready var ray = $Ray
onready var body = $Body
onready var anim = $Anim

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	shoot()

func init(_weapon):
	weapon = _weapon

func shoot():
	var dest = Vector2(RANGE_RAY, 0)
	ray.set_cast_to(dest)
	if ray.is_colliding():
		dest = body.to_local(ray.get_collision_point())
	body.set_point_position(1, dest)

func start():
	ray.set_enabled(true)
	shoot()
	anim.play("fade_in")

func stop():
	anim.play("fade_out")

func disable():
	set_physics_process(false)
	ray.set_enabled(false)
	body.set_visible(false)

func enable():
	set_physics_process(true)
	body.set_visible(true)