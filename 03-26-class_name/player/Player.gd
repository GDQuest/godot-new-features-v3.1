extends KinematicBody2D
class_name Player, "res://assets/sprites/blue_character_icon.png"


export var move_speed := 500
export var jump_force := 850
export var gravity := 2400
export var slope_slide_threshold := 50.0

var velocity := Vector2()

func _physics_process(delta: float) -> void:
	var direction_x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction_x * move_speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP, slope_slide_threshold)
