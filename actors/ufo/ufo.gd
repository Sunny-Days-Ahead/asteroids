extends CharacterBody2D

const SPEED = 150

var laser = preload("res://actors/laser/laser.tscn")

func _ready() -> void:
	global_position.y = randi_range(0,1080)
	global_position.x = randi_range(2020, 2220)
	
	
func _process(delta: float) -> void:
	global_position.x -= SPEED * delta
	if global_position.x <= -200 :
		await get_tree().create_timer(3).timeout
		_ready()
#it is friday in california 
func shoot():
	var new_laser = laser.instantiate()
	new_laser.global_rotation = randf_range(0, TAU)
	new_laser.velocity = SPEED
	new_laser.global_position = $ELaserSpawn.global_position
	$ELaserContainer.add_child(new_laser)


func _on_timer_timeout() -> void:
	shoot()
