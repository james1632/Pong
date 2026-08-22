extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/agains_ai.tscn")


func _on_pv_p_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/agains_player.tscn")
