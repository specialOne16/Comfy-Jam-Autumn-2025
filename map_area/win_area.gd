extends Area2D

var barrier_direction: Vector2i

@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready() -> void:
	static_body_2d.position = barrier_direction * 72


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("open_next_level")

func open_next_level():
		get_tree().reload_current_scene()
