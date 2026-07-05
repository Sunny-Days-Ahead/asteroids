extends CharacterBody2D

@export_category("Variables")
@export var speed = 1
@export var max_speed = 300
@export var rotation_speed = 3

@export_category("Sub Nodes")
@export var laser : PackedScene

const ACCELERATION : float = 100.0

signal player_hit
signal player_shot

var screen_size : Vector2
var rotation_direction = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	
func get_input():
	var direction : Vector2 = Vector2.RIGHT.rotated(rotation)
	rotation_direction = Input.get_axis("left", "right")
	##thrust when up is pressed
	if Input.is_action_pressed("up"):
		velocity += direction * ACCELERATION
		if velocity.length() > max_speed:
			velocity = velocity.normalized() * max_speed
		$thruster.emitting = true
	else:
		$thruster.emitting = false
	##slow down and approach zero when down is pressed
	if Input.is_action_pressed("down"):
		velocity.x = move_toward(velocity.x, 0, 5)
		velocity.y = move_toward(velocity.y, 0, 5)
	##it is friday in california
	if Input.is_action_just_pressed("shoot"):
		$ShootSound.play()
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

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

@warning_ignore("unused_parameter")
func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.collision_layer)
	if area.get_collision_layer_value(1):
		player_hit.emit()
		hit_flash()
	else:
		player_shot.emit()

func hit_flash():
	$Polygon2D.self_modulate = Color(255, 0, 0)
	await get_tree().create_timer(.15).timeout
	$Polygon2D.self_modulate = Color(255, 255, 255)
