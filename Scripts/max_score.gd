extends Button

var max_score: int

func _ready() -> void:
	max_score = int(text)

func _on_pressed() -> void:
	GameManager.max_score = max_score
