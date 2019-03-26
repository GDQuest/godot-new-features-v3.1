extends Camera

export var mouse_sensitivity := 0.4
export(float, 45.0, 90.0) var max_rotation := 45.0

var yaw : float
var pitch : float
var direction := Vector3()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, -max_rotation, max_rotation)
		rotation = Vector3(deg2rad(pitch), deg2rad(yaw), 0)
