extends Spatial

export var initial_rings := 15
export var interval := 20.0

const RING = preload("res://elements/Ring.tscn")

var last_spawn_position := Vector3(0, 0, -interval)

func _ready() -> void:
	for i in range(initial_rings):
		spawn_ring()


func _on_Ring_ship_passed() -> void:
	spawn_ring()

func spawn_ring() -> void:
	var new_ring = RING.instance()
	new_ring.translation = last_spawn_position
	new_ring.connect("ship_passed", self, "_on_Ring_ship_passed")
	add_child(new_ring)
	last_spawn_position.z -= interval
