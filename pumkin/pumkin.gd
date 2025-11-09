extends AnimatableBody2D
class_name Pumkin

const DISTANCE : float = 64
const DURATION = 0.4
const DIRECTION = [Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT, Vector2i.UP]
const PUSH_COUNTDOWN : float = 0.1

var current_push_countdown := PUSH_COUNTDOWN
var last_push_countdown := PUSH_COUNTDOWN
var map_position = Vector2i.ZERO


func player_push(pusher: Node2D, delta: float):
	if current_push_countdown > 0:
		last_push_countdown = current_push_countdown
		current_push_countdown -= delta
		return
	
	var push_direction = position - pusher.position
	var push_angle = Vector2(push_direction.x, push_direction.y).angle()
	var push_index = roundi(push_angle / TAU * DIRECTION.size())
	
	var direction = DIRECTION[push_index]
	EventManager.push_pumkin.emit(self, direction)


func move(direction: Vector2i):
	map_position += direction
	var tween = get_tree().create_tween()
	await tween.tween_property(
		self, 
		"position", 
		LevelsConfig.map_offset + Vector2(
			map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
			map_position.y * LevelsConfig.BASE_TILE_SIZE.y
		), 
		DURATION
	).finished


func place():
	position = LevelsConfig.map_offset + Vector2(
		map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		map_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)


func _physics_process(_delta: float) -> void:
	if last_push_countdown == current_push_countdown:
		current_push_countdown = PUSH_COUNTDOWN
		last_push_countdown = PUSH_COUNTDOWN
	
	last_push_countdown = current_push_countdown
	
