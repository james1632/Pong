class_name Ball extends CharacterBody2D

const MAX_SPEED: float = 2700

@export var speed: float
@export var acceleration: float

@onready var hit_particles: GPUParticles2D = %HitParticles
@onready var direction :Vector2 = Random_Direction()

var Max_y: float = 0.6

var camera: Camera2D

func Random_Direction() -> Vector2:
	var dir: Vector2
	dir.x = [1, -1].pick_random()
	dir.y = randf_range(1, -1)
	return dir.normalized()

func new_direction(collider: Node2D) -> Vector2:
	var ball_y: float = position.y
	var pad_y: float = collider.position.y
	var new_dir: Vector2
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (ball_y - pad_y) / (collider.p_height / 2.0) * Max_y
	return new_dir.normalized()

func particles_effects(collision:KinematicCollision2D, collider: Object) -> void:
	if collider is Player:
		hit_particles.process_material.color = Color(1.0, 0.173, 0.125, 0.784)
	else:
		hit_particles.process_material.color = Color(0.303, 0.365, 0.971, 0.867)
	hit_particles.global_position = collision.get_position()
	hit_particles.restart()

func _physics_process(delta: float) -> void:
	var collision :KinematicCollision2D = move_and_collide(direction * speed * delta)
	
	if collision:
		var collider: Object = collision.get_collider()
		if collider is Player or collider is CPU:
			speed = min(speed + acceleration, MAX_SPEED)
			direction = new_direction(collider) 
			particles_effects(collision, collider)
			camera.trigger_shake()
			$PaddleHit.play()
		else:
			direction = direction.bounce(collision.get_normal())
			$WallHit.play()

# debug speed control below
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			#speed += 30
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			#speed -= 30
