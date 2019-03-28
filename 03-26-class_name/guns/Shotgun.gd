extends Gun

export(int, 5, 25) var spread_percentage := 25
export var projectiles := 4

func _ready() -> void:
	randomize()


func _shoot() -> void:
	._shoot()
	for i in range(projectiles):
		var new_bullet = bullet.instance()
		var bullet_y_spread = randf() * (spread_percentage / 100.0) * sign(rand_range(-1, 1))
		new_bullet.initialize((direction + Vector2(0, bullet_y_spread)).normalized())
		add_child(new_bullet)
		new_bullet.global_position = barrel.global_position
