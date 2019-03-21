extends KinematicBody2D

onready var timer : Timer = $Timer

const BULLET := preload("res://bullet/Bullet.tscn")

export var move_speed := 250
export var jump_force := 500
export var gravity := 900
export var slope_slide_threshold := 50.0

var velocity := Vector2()
var last_direction := 1


func _physics_process(delta: float) -> void:
	var direction_x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction_x * move_speed
	last_direction = direction_x if direction_x != 0 else last_direction

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP, slope_slide_threshold)


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("shoot") and timer.is_stopped():
		shoot()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()


func shoot() -> void:
	var new_bullet := BULLET.instance() as Bullet
	new_bullet.initialize(Vector2.RIGHT * last_direction)
	add_child(new_bullet)
