extends Control

const BAR_ACTIVE = preload("res://menu/settings/bar_active.png")
const BAR_INACTIVE = preload("res://menu/settings/bar_inactive.png")


var back_callback: Callable


func _ready() -> void:
	_setup_slider("Master", $VBoxContainer/Root/MasterVolume/Slider)
	_setup_slider("Music", $VBoxContainer/Root/Music/Slider)
	_setup_slider("Sfx", $VBoxContainer/Root/SFX/Slider)


func _setup_slider(bus_name: String, slider: HBoxContainer):
	var saved_volume = _get_audio_index(bus_name)
	var children: Array = slider.get_children()
	for i in range(saved_volume):
		children[i].texture_normal = BAR_ACTIVE
	for i in range(saved_volume, 6):
		children[i].texture_normal = BAR_INACTIVE
	
	for button in slider.get_children():
		button.pressed.connect(
			func():
				# selected_volume value is in range [1,6]
				var selected_volume = int(button.name)
				_set_audio_index(selected_volume, bus_name)
				
				for i in range(selected_volume):
					children[i].texture_normal = BAR_ACTIVE
				for i in range(selected_volume, 6):
					children[i].texture_normal = BAR_INACTIVE
		)


func _on_button_pressed() -> void:
	if back_callback: back_callback.call()
	else: get_tree().change_scene_to_file("res://menu/main/main.tscn")


func _set_audio_index(index: int, bus_name: String):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(bus_name),
		index * 4 - 24
	)

func _get_audio_index(bus_name: String) -> int:
	var volume = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index(bus_name)
	)
	return roundi(volume / 4) + 6
