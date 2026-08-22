class_name Ball extends CharacterBody2D

const MAX_SPEED: float = 2700

@export var speed: float
@export var acceleration: float

@onready var direction :Vector2 = Vector2.LEFT.rotated(randf_range(-0.5, 0.5)).normalized()


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
			$PaddleHit.play()
		else:
			direction = direction.bounce(collision.get_normal())
			$WallHit.play()
	print(speed, velocity)

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
