extends KinematicBody2D

export var move_speed := 150.0
export var rotate_speed := 50.0


func _physics_process(delta: float) -> void:
	var motion = Vector2(Input.get_action_strength("rotate_right") - Input.get_action_strength("rotate_left"),
	 Input.get_action_strength("backward") - Input.get_action_strength("forward"))
	rotation_degrees += motion.x * rotate_speed * delta
	move_and_collide(Vector2(0, motion.y * move_speed).rotated(rotation) * delta)
