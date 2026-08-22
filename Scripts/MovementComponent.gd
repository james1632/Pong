class_name MovementComponent extends Node

@export var body: CharacterBody2D
@export var speed: float

var direction: float = 0

func tick() -> void:
	if body == null:
		return
	
	body.velocity.y = direction * speed
	body.move_and_slide()
