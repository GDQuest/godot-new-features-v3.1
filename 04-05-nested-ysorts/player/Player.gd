extends KinematicBody2D

export var move_speed := 150.0


func _physics_process(delta: float) -> void:
	var motion := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	var velocity := motion.normalized() * move_speed
	move_and_slide(velocity)
