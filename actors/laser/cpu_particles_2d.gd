extends CPUParticles2D
func _on_expiry_countdown_timeout() -> void:
	queue_free()
