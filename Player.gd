extends CharacterBody2D

const bullet = preload("res://bullet.tscn")

@export var playerSpeed : int = 100
@export var bulletSpeed = 1000
@export var fireRate = 0.2

var canFire = true

func _process(delta):
	#look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("LMB") and canFire:
		shoot()
		
	$Node2D.look_at(get_global_mouse_position())

func _physics_process(delta):
	var direction : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = direction * playerSpeed
	
	move_and_slide()

func shoot():
	var bulletInstance = bullet.instantiate()
	
	get_parent().add_child(bulletInstance)
	bulletInstance.position = $Node2D/Marker2D2.global_position
	bulletInstance.rotation_degrees = rotation_degrees
	bulletInstance.vel = get_global_mouse_position() - bulletInstance.position
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(rotation))
	get_tree().get_root().add_child(bulletInstance)
	canFire	= false
	await get_tree().create_timer(fireRate)
	canFire = true
