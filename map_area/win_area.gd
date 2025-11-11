extends Area2D

@export var barrier_direction: Vector2i
@export var next_scene: PackedScene
@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready() -> void:
	static_body_2d.position = barrier_direction * 72


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("open_next_level")

func open_next_level():
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		get_tree().reload_current_scene()
