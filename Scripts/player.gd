class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent

@onready var p_height: float = $ColorRect.size.y

func _physics_process(_delta: float) -> void:
	input_component.update()
	
	movement_component.direction = input_component.movement_direction
	movement_component.tick()

	if input_component.go_to_main_menu:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
