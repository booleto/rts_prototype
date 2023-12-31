extends Resource
class_name MovementPattern

func next_velocity(rotation: float, position: Vector2, speed : float, time: float, delta : float) -> Vector2:
	return Vector2.ZERO

func next_rotation(rotation: float, position: Vector2, speed : float, time: float, delta : float) -> float:
	return 0
