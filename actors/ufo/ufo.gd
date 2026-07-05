extends CharacterBody2D

const SPEED = 150

var laser = preload("res://actors/e_laser/e_laser.tscn")

signal score_500

func _ready() -> void:
	global_position.y = randi_range(0,1080)
	global_position.x = randi_range(2220, 2420)
	
	
func _process(delta: float) -> void:
	global_position.x -= SPEED * delta
	if global_position.x <= -200 :
		await get_tree().create_timer(3).timeout
		_ready()
#it is friday in california 
func shoot():
	if $VisibleOnScreenNotifier2D.is_on_screen() == true:
		var new_laser = laser.instantiate()
		new_laser.global_rotation = randf_range(0, TAU)
		new_laser.velocity = SPEED
		new_laser.global_position = $ELaserSpawn.global_position
		$ELaserContainer.add_child(new_laser)
		$ShootSound.play()
	else:
		pass 

func _on_timer_timeout() -> void:
	shoot()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	score_500.emit(self)
	await get_tree().create_timer(1).timeout
	queue_free()
