extends KinematicBody2D

onready var timer : Timer = $Timer
onready var sprite : Sprite = $Sprite
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer2D

export var snap : = false
export var move_speed : = 250
export var jump_force : = 500
export var gravity_force : = 900
export var slope_slide_threshold : = 50.0
export var fire_rate : = 4
export var bullet : PackedScene
export var sound_jump : AudioStreamSample
export var sound_shoot : AudioStreamSample

var velocity : = Vector2()


func _ready() -> void:
	timer.wait_time = 1.0 / fire_rate


func _physics_process(delta: float) -> void:
	velocity.y += gravity_force * delta
	
	if snap:
		velocity = move_and_slide_with_snap(velocity, Vector2(0, 32), Vector2.UP, slope_slide_threshold)
	else:
		velocity = move_and_slide(velocity, Vector2.UP, slope_slide_threshold)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		audio_player.play_sound(sound_jump)
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		shoot()
	
	var motion : = Vector2(0, 0)
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.x *= move_speed
	velocity.x = lerp(velocity.x, motion.x, 0.1)
	
	update_animation(velocity)


func shoot() -> void:
	timer.start()
	var new_bullet : = bullet.instance()
	new_bullet.initialize(Vector2.RIGHT * (-1 if sprite.flip_h else 1))
	new_bullet.global_position = global_position
	add_child(new_bullet)
	audio_player.play_sound(sound_shoot)


func update_animation(velocity: Vector2) -> void:
	var animation : = "idle"
	if abs(velocity.x) > 10.0:
		sprite.flip_h = velocity.x < 0
		animation = "run"
	
	if not is_on_floor():
		animation = "jump" if velocity.y < 0 else "fall"
	
	if animation_player.current_animation != animation:
		animation_player.play(animation)
