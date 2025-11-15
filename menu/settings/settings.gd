extends Control

const BAR_ACTIVE = preload("uid://cur3ncxbh6bp7")
const BAR_INACTIVE = preload("uid://ecvc54sa76lr")

@onready var arrow = [
	[$Settings/MarginContainer/VBoxContainer/Root/MasterVolume/HBoxContainer/TextureRect, $Settings/MarginContainer/VBoxContainer/Root/MasterVolume/HBoxContainer/TextureRect2],
	[$Settings/MarginContainer/VBoxContainer/Root/Music/HBoxContainer/TextureRect, $Settings/MarginContainer/VBoxContainer/Root/Music/HBoxContainer/TextureRect2],
	[$Settings/MarginContainer/VBoxContainer/Root/SFX/HBoxContainer/TextureRect, $Settings/MarginContainer/VBoxContainer/Root/SFX/HBoxContainer/TextureRect2]
]

@onready var slider_node = [
	$Settings/MarginContainer/VBoxContainer/Root/MasterVolume/HBoxContainer/Slider, 
	$Settings/MarginContainer/VBoxContainer/Root/Music/HBoxContainer/Slider, 
	$Settings/MarginContainer/VBoxContainer/Root/SFX/HBoxContainer/Slider
]

@onready var slider_value = [0, 0, 0]

var back_callback: Callable
var focus_settings_id: int = 0


func _ready() -> void:
	slider_value[0] = _setup_slider("Master", slider_node[0])
	slider_value[1] = _setup_slider("Music", slider_node[1])
	slider_value[2] = _setup_slider("Sfx", slider_node[2])
	update_focus()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and focus_settings_id > 0:
		focus_settings_id -= 1
		
	if Input.is_action_just_pressed("ui_down") and focus_settings_id < 2:
		focus_settings_id += 1
		
	if Input.is_action_just_pressed("ui_left") and slider_value[focus_settings_id] > 1:
		var button = slider_node[focus_settings_id].get_child(slider_value[focus_settings_id]-2)
		if button: button.pressed.emit()
		
	if Input.is_action_just_pressed("ui_right") and slider_value[focus_settings_id] < 6:
		var button = slider_node[focus_settings_id].get_child(slider_value[focus_settings_id])
		if button: button.pressed.emit()
	
	update_focus()


func _setup_slider(bus_name: String, slider: HBoxContainer) -> int:
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
				
				match bus_name:
					"Master": slider_value[0] = selected_volume
					"Music": slider_value[1] = selected_volume
					"Sfx": slider_value[2] = selected_volume
		)
	
	return saved_volume


func _on_button_pressed() -> void:
	if back_callback: 
		focus_settings_id = 0
		update_focus()
		back_callback.call()
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

func update_focus():
	for i in arrow.size():
		if i == focus_settings_id:
			arrow[i][0].modulate = Color.WHITE
			arrow[i][1].modulate = Color.WHITE
		else:
			arrow[i][0].modulate = Color.TRANSPARENT
			arrow[i][1].modulate = Color.TRANSPARENT
