extends HBoxContainer
class_name ArrowButton

@export var text: String = ""
signal pressed

@onready var texture_rect: TextureRect = $TextureRect
@onready var button: Button = $Button
@onready var texture_rect_2: TextureRect = $TextureRect2

func _ready() -> void:
	button.text = text

func set_focus(focus: bool):
	texture_rect.visible = focus
	texture_rect_2.visible = focus

func _on_button_pressed() -> void:
	pressed.emit()
