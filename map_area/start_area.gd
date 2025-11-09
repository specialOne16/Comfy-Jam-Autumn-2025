extends Area2D

var barrier_direction: Vector2i

@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _ready() -> void:
	static_body_2d.position = barrier_direction * 72
