extends CharacterBody2D
class_name Player


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var pause_movement = false
var pause_game = false
var cutscene = false
var speed = 200


func _ready() -> void:
	EventManager.pushing_pumkin.connect(
		func(is_pushing): pause_movement = is_pushing
	)


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed if not pause_movement and not pause_game and not cutscene else Vector2.ZERO


func handle_collision(collision: KinematicCollision2D, delta: float):
	var collider = collision.get_collider()
	
	if collider is Pumkin: collider.player_push(self, delta)

func place(map_position: Vector2i):
	position = Vector2(
		map_position.x * LevelsConfig.BASE_TILE_SIZE.x, 
		map_position.y * LevelsConfig.BASE_TILE_SIZE.y
	)


func _physics_process(delta):
	get_input()
	
	update_animation()
	
	if velocity != Vector2.ZERO and not AudioPlayer.footstep.playing: AudioPlayer.footstep.play()
	
	var collision = move_and_collide(velocity * delta)
	if collision: handle_collision(collision, delta)

var looking = {
	"dir": "down",
	"flip": 1
}
func update_animation():
	if pause_movement:
		sprite.play("push_%s" % looking.dir)
		return
	if velocity == Vector2.ZERO:
		sprite.play("idle_%s" % looking.dir)
		return
	
	var direction = velocity.angle()
	
	if direction >= -PI/4 and direction <= PI/4:
		looking.dir = "side"
		looking.flip = -1
	elif direction > PI/4 and direction < 3*PI/4:
		looking.dir = "down"
		looking.flip = 1
	elif direction < -PI/4 and direction > -3*PI/4:
		looking.dir = "up"
		looking.flip = 1
	else:
		looking.dir = "side"
		looking.flip = 1
		
	sprite.scale.x = abs(sprite.scale.x) * looking.flip
	sprite.play("move_%s" % looking.dir)
