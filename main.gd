extends Node2D

var player_score
var big_asteroid = preload("res://big_asteroid.tscn")
var small_asteroid = preload("res://small_asteroid.tscn")

@export var asteroid_container : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_score = 0
	
	spawn_asteroid()
	spawn_asteroid()
	spawn_asteroid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 

func _on_score_100(hit_asteroid) -> void:
	player_score += 100
	$HUD/PlayerScore.text = "Score: " + str(player_score)
	spawn_small_asteroid(hit_asteroid.global_position.x, hit_asteroid.global_position.y + 50)
	spawn_small_asteroid(hit_asteroid.global_position.x + 50, hit_asteroid.global_position.y)
	spawn_small_asteroid(hit_asteroid.global_position.x - 50, hit_asteroid.global_position.y -50)
	hit_asteroid.queue_free()
	
func _on_score_50(hit_asteroid) -> void:
	player_score += 50
	$HUD/PlayerScore.text = "Score: " + str(player_score)
	hit_asteroid.queue_free()
	
func _on_timer_timeout() -> void:
	spawn_asteroid()
	
func spawn_asteroid():
	var big_asteroid_instance = big_asteroid.instantiate()
	asteroid_container.add_child(big_asteroid_instance)
	big_asteroid_instance.score_100.connect(_on_score_100)

func spawn_small_asteroid(x, y):
	var small_asteroid_instance = small_asteroid.instantiate()
	asteroid_container.add_child(small_asteroid_instance)
	small_asteroid_instance.score_50.connect(_on_score_50)
	small_asteroid_instance.global_position.x = x
	small_asteroid_instance.global_position.y = y
