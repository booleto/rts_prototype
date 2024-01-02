extends Resource
class_name BulletPattern

enum status {
	ENDED,
	ONGOING
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(tick : int, position : Vector2, angle : float, params : Dictionary = {}) -> status:
	return status.ENDED
