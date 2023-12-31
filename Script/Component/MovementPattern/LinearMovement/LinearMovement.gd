extends MovementPattern
class_name LinearMovement

func next_velocity(rotation: float, position: Vector2, speed : float, time: float, delta : float) -> Vector2:
	return Vector2.from_angle(rotation) * speed * delta

func next_rotation(rotation: float, position: Vector2, speed : float, time: float, delta : float) -> float:
	return rotation
