extends Control

signal restart
signal pause(is_paused: bool)

@onready var pause_box: PanelContainer = $PauseBox
@onready var settings: Control = $Settings
@onready var buttons: Array[ArrowButton] = [$PauseBox/VBoxContainer/VBoxContainer/ResumeButton, $PauseBox/VBoxContainer/VBoxContainer/SettingsButton, $PauseBox/VBoxContainer/VBoxContainer/ExitToTitleButton]

var focus_button_id: int = 0

func _ready() -> void:
	pause_box.visible = false
	settings.visible = false
	settings.back_callback = Callable(self, "close_settings")


func _process(_delta: float) -> void:
	if not pause_box.visible or settings.visible: return
	
	if Input.is_action_just_pressed("ui_up") and focus_button_id > 0:
		buttons[focus_button_id].set_focus(false)
		focus_button_id -= 1
		buttons[focus_button_id].set_focus(true)
		
	if Input.is_action_just_pressed("ui_down") and focus_button_id < 2:
		buttons[focus_button_id].set_focus(false)
		focus_button_id += 1
		buttons[focus_button_id].set_focus(true)
	
	if Input.is_action_just_pressed("ui_accept"):
		buttons[focus_button_id].pressed.emit()


func _on_texture_button_pressed() -> void:
	focus_button_id = 0
	for i in buttons.size():
		buttons[i].set_focus(i == focus_button_id)
	
	pause_box.visible = true
	pause.emit(true)


func _on_texture_button_2_pressed() -> void:
	if pause_box.visible == true: return
	restart.emit()


func _on_resume_button_pressed() -> void:
	pause_box.visible = false
	pause.emit(false)


func _on_settings_button_pressed() -> void:
	settings.visible = true
	pause_box.visible = false


func _on_exit_to_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/main/main.tscn")

func close_settings():
	settings.visible = false
	pause_box.visible = true
