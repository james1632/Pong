class_name CPU extends CharacterBody2D

@onready var movement_component: MovementComponent = %MovementComponent

@onready var p_height: float = $ColorRect.size.y
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var fixed_x: float = position.x

var distance: float

func _physics_process(delta: float) -> void:
	var ball: CharacterBody2D = get_parent().get_node_or_null("Ball")
	
	if ball == null:
		movement_component.direction = 0
		movement_component.tick()
		return
	
	distance = position.y - ball.position.y
	
	if abs(distance) > movement_component.speed * delta:
		if distance > 0:
			movement_component.direction = -1.0
		else:
			movement_component.direction = 1.0
	else: 
		movement_component.direction = 0.0
	
	movement_component.tick()
	
	position.y = clamp(position.y, 0, screen_size.y - p_height)
	position.x = fixed_x
