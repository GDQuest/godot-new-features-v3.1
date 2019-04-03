extends MeshInstance

export var move_speed := 25.0


func _process(delta: float) -> void:
	translation.z -= delta * move_speed
