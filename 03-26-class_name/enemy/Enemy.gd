extends KinematicBody2D
class_name Enemy

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var collision_shape : CollisionShape2D = $CollisionShape2D

export var health := 100


func damage(value: int) -> void:
	if health == 0:
		return
	health = max(0, health - value)
	if health == 0:
		animation_player.play("die")
		collision_shape.queue_free()
		yield(animation_player, "animation_finished")
		queue_free()
	animation_player.play("damage")
