extends CharacterBody2D

var speed : int 
var rotation_speed : int
var angle : float 
var heading : Vector2
var screen_size : Vector2

@export var small_asteroid : PackedScene

signal score_100
signal score_50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	
	var length = get_viewport().size.y
	var width = get_viewport().size.x
	var randx = rng.randi_range(0, width)
	var randy = rng.randi_range(0, length)
	global_position = Vector2 (randx, randy)
	
	speed = randi_range(-100, 100)
	rotation_speed = randi_range(-3,3)
	screen_size = get_viewport_rect().size 
	angle = randi_range(0, 360)
	heading = Vector2.from_angle(deg_to_rad(angle))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	rotation += rotation_speed * delta 
	position += heading * speed * delta
	if position.x > 2020:
		position.x = -100
	if position.y > 1180:
		position.y = -100
	if position.x < -100:
		position.x = 2020
	if position.y < -100:
		position.y = 1180


@warning_ignore("unused_parameter")
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	score_100.emit(self) ##Return the name of the node with the signal

	#Trigger the one-shot emission so they naturally decay
	

func _on_score_50():
	score_50.emit()
