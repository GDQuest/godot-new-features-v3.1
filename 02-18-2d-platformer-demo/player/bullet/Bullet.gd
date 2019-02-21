extends Area2D

export var move_speed : = 500.0

var direction : Vector2


func _ready() -> void:
	set_as_toplevel(true)
	connect("body_entered", self, "_on_body_entered")


func _process(delta: float) -> void:
	position += move_speed * direction * delta


func _on_body_entered(body) -> void:
	if body.is_a_parent_of(self):
		return
	queue_free()


func initialize(_direction: Vector2) -> void:
	direction = _direction
