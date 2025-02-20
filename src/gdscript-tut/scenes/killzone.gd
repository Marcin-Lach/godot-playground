extends Area2D

# https://youtu.be/LOhfqjmasi0?si=4J6gHdkY24banGz_&t=3068

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
