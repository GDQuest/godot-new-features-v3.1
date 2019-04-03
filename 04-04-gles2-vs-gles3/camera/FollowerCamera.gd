extends Camera

var offset := Vector3()

func _ready() -> void:
	if get_child_count() == 0:
		return
	get_child(0).set_as_toplevel(true)
	offset = get_child(0).global_transform.origin - global_transform.origin

func _process(delta: float) -> void:
	translation = get_child(0).global_transform.origin - offset
