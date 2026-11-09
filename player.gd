extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 6.0
@export var gravity := 15

@export var coyote_time := 0.12
@export var jump_buffer_time := 0.12

@onready var sprite : AnimatedSprite3D = %AnimatedSprite3D

var coyote_timer := 0.0
var jump_buffer_timer := 0.0

func _physics_process(delta):
	
	# -- track last time we used floor (coyote time)
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	else:
		jump_buffer_timer -= delta
	
	# -- Jumping + apple
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0.0
		coyote_timer = 0.0
	
	
	# -- x = left/right | y = up/down
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var dir := Vector3.ZERO
	var cam := get_viewport().get_camera_3d()
	
	# -- Uses current camera as basis
	if cam:
		var cam_basis := cam.global_transform.basis
		var forward := -cam_basis.z
		forward.y = 0.0
		
		if forward.length_squared() < 0.001:
			forward = cam_basis.y
			forward.y = 0.0
		
		forward = forward.normalized()
		
		var right := cam_basis.x
		right.y = 0.0
		right = right.normalized()
		
		dir = right * input.x + forward * -input.y
		if dir.length() > 1.0:
			dir = dir.normalized()
	
	velocity.x = dir.x * speed
	velocity.z = dir.z * speed
	
	move_and_slide()
	_update_animation(input, dir)


func _update_animation(input: Vector2, dir: Vector3):
	
	# -- filps character when turned
	if input.x != 0.0:
		sprite.flip_h = -input.x < 0.0
	
	if not is_on_floor():
		sprite.play("Idel")
		#print("jumping")
	elif dir != Vector3.ZERO:
		sprite.play("Idel")
		#print("walking")
	else:
		sprite.play("Idel")
		#print("idel")
