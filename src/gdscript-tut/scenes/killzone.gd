extends Area2D

# https://youtu.be/LOhfqjmasi0?si=4J6gHdkY24banGz_&t=3068

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
