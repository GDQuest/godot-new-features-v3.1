extends Gun

func _shoot() -> void:
	._shoot()
	timer.start()
	var new_bullet := bullet.instance()
	new_bullet.initialize(direction)
	add_child(new_bullet)
	new_bullet.global_position = barrel.global_position
