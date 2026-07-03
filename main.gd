extends Node2D

var player_score
var big_asteroid = preload("res://actors/big_asteroid/big_asteroid.tscn")
var small_asteroid = preload("res://actors/small_asteroid/small_asteroid.tscn")
var explosion = preload("res:///actors/explosion/explosion.tscn")

@export var asteroid_container : Node

@export_category("Player Vars")
@export var player_health : int = 3
@export var player_lives : int = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_score = 0
	spawn_asteroid(8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if player_health == 0 : 
		var length = get_viewport().size.y
		var width = get_viewport().size.x
		var explosion_instance = explosion.instantiate()
		asteroid_container.add_child(explosion_instance)
		explosion_instance.global_position = $PlayerShip.global_position
		await get_tree().process_frame 
		player_lives -= 1 
		$HUD/Control/MarginContainer/PlayerLives.text = "Lives: " + str(player_lives)
		player_health = 3
		$HUD/Control/MarginContainer3/PlayerHealth.text = "Health: " + str(player_health)
		$PlayerShip.global_position = Vector2(width/2, length/2)
	if player_lives == 0: 
		get_tree().quit()


func _on_score_100(hit_asteroid) -> void:
	player_score += 100
	var explosion_instance = explosion.instantiate()
	asteroid_container.add_child(explosion_instance)
	explosion_instance.global_position = hit_asteroid.global_position
	$HUD/Control/MarginContainer2/PlayerScore.text = "Score: " + str(player_score)
	spawn_small_asteroid(hit_asteroid.global_position.x, hit_asteroid.global_position.y + 50)
	spawn_small_asteroid(hit_asteroid.global_position.x + 50, hit_asteroid.global_position.y)
	spawn_small_asteroid(hit_asteroid.global_position.x - 50, hit_asteroid.global_position.y -50)
	hit_asteroid.queue_free()
	
func _on_score_50(hit_asteroid) -> void:
	player_score += 50
	var explosion_instance = explosion.instantiate()
	asteroid_container.add_child(explosion_instance)
	explosion_instance.global_position = hit_asteroid.global_position
	$HUD/Control/MarginContainer2/PlayerScore.text = "Score: " + str(player_score)
	hit_asteroid.queue_free()
	
func _on_score_0A(hit_asteroid) -> void:
	var explosion_instance = explosion.instantiate()
	asteroid_container.add_child(explosion_instance)
	explosion_instance.global_position = hit_asteroid.global_position
	$HUD/Control/MarginContainer2/PlayerScore.text = "Score: " + str(player_score)
	spawn_small_asteroid(hit_asteroid.global_position.x, hit_asteroid.global_position.y + 50)
	spawn_small_asteroid(hit_asteroid.global_position.x + 50, hit_asteroid.global_position.y)
	spawn_small_asteroid(hit_asteroid.global_position.x - 50, hit_asteroid.global_position.y -50)
	hit_asteroid.queue_free()
	
func _on_score_0B(hit_asteroid):
	var explosion_instance = explosion.instantiate()
	asteroid_container.add_child(explosion_instance)
	explosion_instance.global_position = hit_asteroid.global_position
	$HUD/Control/MarginContainer2/PlayerScore.text = "Score: " + str(player_score)
	hit_asteroid.queue_free()
	
func _on_asteroid_timer_timeout() -> void:
	spawn_asteroid(2)

func _on_player_ship_player_hit() -> void:
	player_health -= 1 
	$HUD/Control/MarginContainer3/PlayerHealth.text = "Health: " + str(player_health)
	
func spawn_asteroid(count: int):
	for value in count:
		var big_asteroid_instance = big_asteroid.instantiate()
		asteroid_container.add_child(big_asteroid_instance)
		big_asteroid_instance.score_100.connect(_on_score_100)
		big_asteroid_instance.score_0A.connect(_on_score_0A)

func spawn_small_asteroid(x, y):
	var small_asteroid_instance = small_asteroid.instantiate()
	await get_tree().process_frame
	asteroid_container.add_child(small_asteroid_instance)
	small_asteroid_instance.score_50.connect(_on_score_50)
	small_asteroid_instance.score_0B.connect(_on_score_0B)
	small_asteroid_instance.global_position.x = x 
	small_asteroid_instance.global_position.y = y
