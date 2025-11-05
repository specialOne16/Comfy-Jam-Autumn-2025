extends Control

const BAR_ACTIVE = preload("res://menu/settings/bar_active.png")
const BAR_INACTIVE = preload("res://menu/settings/bar_inactive.png")


func _ready() -> void:
	_setup_slider($VBoxContainer/Root/MasterVolume/Slider)
	_setup_slider($VBoxContainer/Root/Music/Slider)
	_setup_slider($VBoxContainer/Root/SFX/Slider)


func _setup_slider(slider: HBoxContainer):
	for button in slider.get_children():
		button.pressed.connect(
			func():
				var children: Array = slider.get_children()
				for i in range(int(button.name)):
					children[i].texture_normal = BAR_ACTIVE
				for i in range(int(button.name), 6):
					children[i].texture_normal = BAR_INACTIVE
		)
