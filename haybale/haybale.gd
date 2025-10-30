extends AnimatableBody2D
class_name Haybale

const DISTANCE : float = 64
const DURATION = 0.4
const DIRECTION = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]


func push(pusher: Node2D):
	var push_angle = roundi(pusher.position.angle_to_point(position) / TAU * DIRECTION.size())
	var direction = DIRECTION[push_angle]
	
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "position", position + direction * DISTANCE, DURATION).finished
