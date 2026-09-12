class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent

@onready var p_height: float = $ColorRect.size.y
@onready var screen_size: Vector2 = get_viewport_rect().size
@onready var fixed_x: float = position.x

func _physics_process(_delta: float) -> void:
	input_component.update()
	
	movement_component.direction = input_component.movement_direction
	movement_component.tick()
	
	position.x = fixed_x
	position.y = clamp(position.y, 0, screen_size.y - p_height)
	
	if input_component.go_to_main_menu:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
