class_name InputComponent extends Node

@export var up: String
@export var down: String

var movement_direction: float = 0
var go_to_main_menu: bool = false

func update() -> void:
	movement_direction = Input.get_axis(up, down)
	go_to_main_menu = Input.is_action_just_pressed("escape")
