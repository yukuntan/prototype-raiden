extends "res://scenes/bullet.gd"

var velocity = Vector2(0, 0)

onready var body = $Body
onready var cold = $Cold
onready var hit = $Hit

func _ready():
	body.texture = load(weapon.data.image)
	hit.get_node("Col").shape.set_extents(weapon.data.hit_rect)
	hit.set_collision_mask(weapon.data.hit_target)

func _physics_process(delta):
	translate(velocity * delta)

func _on_hit(body):
	hit(body)

func _on_screen_exited():
	hit(null)

func start():
	.start()
	set_visible(true)
	set_physics_process(true)
	hit.set_monitoring(true)
	hit.set_monitorable(true)
	velocity = Vector2(weapon.data.speed, 0).rotated(rotation)

func stop():
	.stop()
	set_visible(false)
	set_physics_process(false)
	hit.set_monitoring(false)
	hit.set_monitorable(false)

func destroy():
	queue_free()

func hit(body):
	if body:
		weapon.blast(get_global_position())
	
	if weapon:
		weapon.remove_bullet(self)
	else:
		destroy()