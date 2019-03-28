extends Node2D
class_name Gun

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var barrel : Position2D = $Sprite/Barrel
onready var sprite : Sprite = $Sprite
onready var timer : Timer = $Timer

export var fire_rate := 5
export var bullet : PackedScene

var direction := Vector2.RIGHT

func _ready() -> void:
	timer.wait_time = 1.0 / fire_rate


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("shoot") and timer.is_stopped():
		_shoot()
	elif event.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		global_scale.x = -abs(global_scale.x)
	elif event.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
		global_scale.x = abs(global_scale.x)


func _shoot() -> void:
	animation_player.play("shoot")
