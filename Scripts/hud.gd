extends CanvasLayer

func _ready() -> void:
	$GameOver.hide()

func update_cpu(cpu_score: int) -> void:
	$CPUScore.text = str(cpu_score)

func update_p(p_score: int) -> void:
	$PScore.text = str(p_score)


func _on_main_gameover(winner: String, is_player_won: bool) -> void:
	$GameOver.text = "Game Over\n" + winner + " won"
	if is_player_won:
		$GameOver.position.x -= 300
	else:
		$GameOver.position.x += 300
	$GameOver.show()
