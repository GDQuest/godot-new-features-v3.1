extends KinematicBody

onready var camera : Camera = $Camera

export var move_speed := 20.0
export var gravity := 90.0
export var jump_force := 25.0

var velocity : Vector3


func _physics_process(delta: float) -> void:
	var motion := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward"))
	
	motion = motion.normalized()
	velocity.x = motion.x * move_speed
	velocity.z = motion.y * move_speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
	
	velocity.y -= gravity * delta
	
	velocity = move_and_slide(velocity.rotated(Vector3.UP, camera.rotation.y), Vector3.UP)
	