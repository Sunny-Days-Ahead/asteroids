extends CPUParticles2D

func _process(delta: float) -> void:
	self.emitting = true 

func _on_finished() -> void:
	queue_free()
