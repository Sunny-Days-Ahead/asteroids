extends CPUParticles2D
func _on_expiry_countdown_timeout() -> void:
	queue_free()


func _on_finished() -> void:
	queue_free() # Replace with function body.
