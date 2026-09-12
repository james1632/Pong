extends Node2D

@onready var ball_start: Vector2 = get_viewport_rect().size / 2
@onready var max_score: int = GameManager.max_score

signal gameover(winner: String, is_player_won: bool)

var ball_scene: PackedScene = preload("res://Scenes/ball.tscn")
var score_p: int
var score_cpu: int

func _ready() -> void:
	new_game()

func new_game() -> void:
	score_p = 0
	score_cpu = 0
	new_ball()
 
func _on_p_win_body_entered(body: Node2D) -> void:
	score_cpu += 1
	$HUD.update_cpu(score_cpu)
	new_ball(body)
	if get_node_or_null("%CPU") == null:
		game_over(score_cpu, "Player 2", false)
	else:
		game_over(score_cpu, "AI", false)

func _on_cpu_win_body_entered(body: Node2D) -> void:
	score_p += 1
	$HUD.update_p(score_p)
	new_ball(body)
	if get_node_or_null("%CPU") == null:
		game_over(score_p, "Player 1", true)
	else:
		game_over(score_p, "Player", true)

func new_ball(body: Node2D = null) -> void:
	if body is Ball:
		body.queue_free()
	await get_tree().create_timer(2).timeout
	var ball: CharacterBody2D = ball_scene.instantiate()
	ball.position = ball_start
	add_child(ball)
	ball.camera = $Camera2D

func game_over(score: int, winner: String, is_player_won: bool) -> void:
	
	if score >= max_score:
		gameover.emit(winner, is_player_won)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
