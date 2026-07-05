extends CanvasModulate
func _ready() -> void:
	self.hide()

func flash_start():
	self.show()
func flash_end():
	self.hide()
