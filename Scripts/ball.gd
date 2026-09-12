class_name Ball extends CharacterBody2D

const MAX_SPEED: float = 2700

@export var speed: float
@export var acceleration: float
@onready var hit_particles: GPUParticles2D = %HitParticles

@onready var direction :Vector2 = Vector2.LEFT.rotated(randf_range(-0.5, 0.5)).normalized()

var camera: Camera2D

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	var collision :KinematicCollision2D = move_and_collide(velocity * delta)
	var collider: Node2D

	if collision:
		collider = collision.get_collider()
		if collider is Player or collider is CPU:
			if speed <= MAX_SPEED:
				speed += acceleration
			direction = new_direction(collider)
			if collider is Player:
				hit_particles.process_material.color = Color(1.0, 0.173, 0.125, 0.784)
			else:
				hit_particles.process_material.color = Color(0.303, 0.365, 0.971, 0.867)
			hit_particles.global_position = collision.get_position()
			hit_particles.restart()
			camera.trigger_shake()
			$PaddleHit.play()
		else:
			direction = direction.bounce(collision.get_normal())
			$WallHit.play()

func new_direction(collider: Node2D) -> Vector2:
	var ball_y: float = position.y
	var pad_y: float = collider.position.y
	var new_dir: Vector2
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (ball_y - pad_y) / (collider.p_height / 2.0)
	return new_dir.normalized()
