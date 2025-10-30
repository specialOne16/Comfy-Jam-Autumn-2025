extends CharacterBody2D
class_name Player


@export var speed = 400
var pause_movement = false


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed if not pause_movement else Vector2.ZERO


func handle_collision(collision: KinematicCollision2D, delta: float):
	var collider = collision.get_collider()
	
	if collider is Haybale:
		pause_movement = true
		await collider.push(self, delta)
		pause_movement = false


func _physics_process(delta):
	get_input()
	
	var collision = move_and_collide(velocity * delta)
	if collision: handle_collision(collision, delta)
