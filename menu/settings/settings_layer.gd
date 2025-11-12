extends CanvasLayer

@onready var settings: Panel = $Settings
@onready var open_settings_button: Button = $OpenSettingsButton

func _ready() -> void:
	settings.back_callback = Callable(self, "close_settings")
	settings.visible = false

func open_settings():
	settings.visible = true

func close_settings():
	settings.visible = false
