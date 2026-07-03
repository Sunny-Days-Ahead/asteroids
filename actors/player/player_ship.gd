extends CharacterBody2D

@export_category("Variables")
@export var speed = 1
@export var max_speed = 30
@export var rotation_speed = 1.5

@export_category("Sub Nodes")
@export var laser : PackedScene

signal player_hit

var screen_size : Vector2
var rotation_direction = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity += transform.x * Input.get_axis("down", "up") * move_toward(speed, max_speed, .5) 
	
	if Input.is_action_just_pressed("shoot"):
		var new_laser := laser.instantiate()
		new_laser.global_rotation = self.rotation
		new_laser.global_position = $Marker2D.global_position
		new_laser.ship_velocity = self.velocity
		var bullet_container = $BulletContainer
		bullet_container.add_child(new_laser)
	else:
		pass

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func _process(delta: float) -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func _on_area_2d_area_entered(area: Area2D) -> void:
	player_hit.emit()
