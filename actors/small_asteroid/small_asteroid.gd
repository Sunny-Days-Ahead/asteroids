extends CharacterBody2D

var speed : int 
var rotation_speed : int
var angle : float 
var heading : Vector2
var screen_size : Vector2

signal score_50
signal score_0B
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	
	var length = get_viewport().size.y 
	var width = get_viewport().size.x
	var randx = rng.randi_range(-100, width+100)
	var randy = rng.randi_range(-100, length+100) 
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
	move_and_collide(heading)
	
	
@warning_ignore("unused_parameter")
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print(area.collision_layer)
	var is_not_e_bullet = area.get_collision_layer_value(2)
	if is_not_e_bullet:
		score_50.emit(self)
	else:
		score_0B.emit(self)

	
	

	
