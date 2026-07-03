extends Area2D

var screen_size : Vector2
var speed = 600
var velocity = 0.0
var ship_velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Velocity is in the "forward" direction -- bullet is facing right in the scene view, so take the right direction and rotate it the same as the node's rotation
	velocity = Vector2.RIGHT.rotated(self.global_rotation) * speed
	
	# Add the ship's velocity also, so the bullets always go faster than the ship. clip the incoming velocity x and y so they can't be negative
	velocity += ship_velocity.maxf(0.0)    #maxf(0.0) picks whichever is larger between 0.0 and x/y

	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Every frame, adjust the position based on velocity and delta
	position += velocity * delta
	if position.x > 2020:
		position.x = -100
	if position.y > 1180:
		position.y = -100
	if position.x < -100:
		position.x = 2020
	if position.y < -100:
		position.y = 1180
	await get_tree().create_timer(1.2).timeout
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
