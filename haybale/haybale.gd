extends AnimatableBody2D
class_name Haybale

const DISTANCE : float = 64
const DURATION = 0.4
const DIRECTION = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
const PUSH_COUNTDOWN : float = 0.3

var current_push_countdown := PUSH_COUNTDOWN
var last_push_countdown := PUSH_COUNTDOWN

func push(pusher: Node2D, delta: float):
	if current_push_countdown > 0:
		last_push_countdown = current_push_countdown
		current_push_countdown -= delta
		return
	
	var push_angle = roundi(pusher.position.angle_to_point(position) / TAU * DIRECTION.size())
	var direction = DIRECTION[push_angle]
	
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "position", position + direction * DISTANCE, DURATION).finished


func _physics_process(delta: float) -> void:
	if last_push_countdown == current_push_countdown:
		current_push_countdown = PUSH_COUNTDOWN
		last_push_countdown = PUSH_COUNTDOWN
	
	last_push_countdown = current_push_countdown
