extends Node

# https://youtu.be/LOhfqjmasi0?si=wVrr8OkdOWyqHPT-&t=3753
@onready var score_label: Label = %ScoreLabel

var score : int = 0

func _ready() -> void:
	score_label.text = "Score: " + str(score)

func add_point() -> void:
	score += 1
	print("score: " + str(score))
	score_label.text = "Score: " + str(score)
