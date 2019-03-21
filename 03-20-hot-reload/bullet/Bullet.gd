extends Area2D
class_name Bullet

export var move_speed := 1000.0

var direction := Vector2()


func _ready() -> void:
	set_as_toplevel(true)
	connect("body_entered", self, "_on_body_entered")


func _process(delta: float) -> void:
	global_position += direction * move_speed * delta


func _on_body_entered(body) -> void:
	if body.is_a_parent_of(self):
		return
	queue_free()


func initialize(_direction: Vector2) -> void:
	direction = _direction
