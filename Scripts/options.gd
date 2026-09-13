extends Control

@onready var spin_box: SpinBox = $CanvasLayer/SpinBox


func _on_spin_box_value_changed(value: float) -> void:
	GameManager.max_score = int(value)


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
