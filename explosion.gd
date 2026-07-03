extends CPUParticles2D

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	self.emitting = true 

func _on_finished() -> void:
	queue_free()
