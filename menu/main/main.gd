extends Panel

@onready var menu_music: AudioStreamPlayer = AudioPlayer.menu_music
@onready var settings: Control = $Settings
@onready var real_button: Array[Button] = [$Play, $Settings2, $Settings3]

var focus_id = 0

@onready var quit_button: TextureRect = $QuitButton
@onready var settings_button: TextureRect = $SettingsButton
@onready var play_button: TextureRect = $PlayButton

func _ready() -> void:
	settings.visible = false
	settings.back_callback = func(): settings.visible = false
	Cutscene.stage = 0
	if not menu_music.playing:
		menu_music.play(6)
	
	for button in real_button:
		button.modulate = Color.TRANSPARENT

func _process(_delta: float) -> void:
	if settings.visible: return
	
	if Input.is_action_just_pressed("ui_left"):
		focus_id -= 1
	if Input.is_action_just_pressed("ui_right"):
		focus_id += 1
	if Input.is_action_just_pressed("ui_accept"):
		match focus_id:
			-1: _on_settings_pressed()
			0: _on_play_pressed()
			1: _on_settings_3_pressed()
	focus_id = clampi(focus_id, -1, 1)
	
	update_focus()

func update_focus():
	quit_button.texture = preload("uid://cbc7wun0gkoxl") if focus_id == 1 else preload("uid://btqht5h0roat3")
	play_button.texture = preload("uid://b4muf7qbgnybd") if focus_id == 0 else preload("uid://cukkgipgrrhaj")
	settings_button.texture = preload("uid://yt6p12n8ck4y") if focus_id == -1 else preload("uid://tmps0m73xivs")

func _on_play_pressed() -> void:
	menu_music.stop()
	get_tree().change_scene_to_file("res://cutscene/cutscene.tscn")


func _on_settings_pressed() -> void:
	settings.visible = true


func _on_settings_3_pressed() -> void:
	get_tree().quit()


func _on_play_mouse_entered() -> void:
	focus_id = 0


func _on_settings_2_mouse_entered() -> void:
	focus_id = -1


func _on_settings_3_mouse_entered() -> void:
	focus_id = 1
