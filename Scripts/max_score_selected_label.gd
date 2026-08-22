extends Label


func _process(_delta: float) -> void:
	var max_score: int = GameManager.max_score
	text = "Max Score Selected:\n" + str(max_score)
