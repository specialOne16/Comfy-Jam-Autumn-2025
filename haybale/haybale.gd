extends AnimatableBody2D
class_name Haybale

signal pushed(haybale: Haybale, direction: Vector2i)

const DISTANCE : float = 64
const DURATION = 0.4
const DIRECTION = [Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT, Vector2i.UP]
const PUSH_COUNTDOWN : float = 0.1

var current_push_countdown := PUSH_COUNTDOWN
var last_push_countdown := PUSH_COUNTDOWN

func push(pusher: Node2D, delta: float):
	if current_push_countdown > 0:
		last_push_countdown = current_push_countdown
		current_push_countdown -= delta
		return
	
	var push_direction = position - pusher.position
	var push_angle = Vector2(push_direction.x, push_direction.y * 2).angle()
	var push_index = roundi(push_angle / TAU * DIRECTION.size())
	
	var direction = DIRECTION[push_index]
	
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "position", position + direction * DISTANCE, DURATION).finished


func _physics_process(delta: float) -> void:
	if last_push_countdown == current_push_countdown:
		current_push_countdown = PUSH_COUNTDOWN
		last_push_countdown = PUSH_COUNTDOWN
	
	last_push_countdown = current_push_countdown
