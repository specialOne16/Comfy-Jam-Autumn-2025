extends Area2D

@export var barrier_direction: Vector2i
@onready var static_body_2d: StaticBody2D = $StaticBody2D

signal win_area_reached

func _ready() -> void:
	static_body_2d.position = barrier_direction * 72


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		win_area_reached.emit()
