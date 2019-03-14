extends KinematicBody2D

onready var timer : Timer = $Timer
onready var sprite : Sprite = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer2D

export var snap := false
export var move_speed := 250
export var jump_force := 500
export var gravity := 900
export var slope_slide_threshold := 50.0

var velocity := Vector2()


func _physics_process(delta: float) -> void:
	var direction_x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction_x * move_speed

	if Input.is_action_just_pressed("jump") and snap:
		velocity.y = -jump_force
		snap = false
		audio_player.play()
	
	velocity.y += gravity * delta
	
	var snap_vector = Vector2(0, 32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, slope_slide_threshold)
	
	if is_on_floor() and (Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left")):
		velocity.y = 0

	var just_landed := is_on_floor() and not snap
	if just_landed:
		snap = true
	
	update_animation(velocity)


func update_animation(velocity: Vector2) -> void:
	var animation := "idle"
	if abs(velocity.x) > 10.0:
		sprite.flip_h = velocity.x < 0
		animation = "run"
	
	if not is_on_floor():
		animation = "jump" if velocity.y < 0 else "fall"
	
	if animation_player.current_animation != animation:
		animation_player.play(animation)
