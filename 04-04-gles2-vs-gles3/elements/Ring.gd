extends Spatial

signal ship_passed

onready var lights : Spatial = $Outter/Lights

export var random_colors := true
export var rotate := true
export var rotate_speed := 5.0

var rotation_direction := 1

func _ready() -> void:
	randomize()
	set_process(rotate)
	rotation_direction = sign(randf() * 2 - 1)
	if random_colors:
		for light in lights.get_children():
			(light as OmniLight).light_color = Color(randf(), randf(), randf())


func _process(delta: float) -> void:
	rotation.z += delta * rotation_direction * rotate_speed


func _on_Area_area_entered(area: Area):
		emit_signal("ship_passed")
