extends CharacterBody2D
class_name Player


@export var speed = 400

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var pause_movement = false


func _ready() -> void:
	EventManager.pushing_pumkin.connect(
		func(is_pushing): pause_movement = is_pushing
	)


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed if not pause_movement else Vector2.ZERO


func handle_collision(collision: KinematicCollision2D, delta: float):
	var collider = collision.get_collider()
	
	if collider is Pumkin: collider.player_push(self, delta)

func place(map_position: Vector2i):
	position = LevelsConfig.MAP_OFFSET + Vector2(
		map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		map_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)


func _physics_process(delta):
	get_input()
	
	update_animation()
	
	var collision = move_and_collide(velocity * delta)
	if collision: handle_collision(collision, delta)

func update_animation():
	if velocity == Vector2.ZERO:
		sprite.play("default")
		return
	
	var direction = velocity.angle()
	print(direction, PI/4)
	
	if direction >= -PI/4 and direction <= PI/4:
		sprite.scale.x = -0.2
		sprite.play("move_side")
	elif direction > PI/4 and direction < 3*PI/4:
		sprite.scale.x = 0.2
		sprite.play("move_down")
	elif direction < -PI/4 and direction > -3*PI/4:
		sprite.scale.x = 0.2
		sprite.play("move_up")
	else:
		sprite.scale.x = 0.2
		sprite.play("move_side")
