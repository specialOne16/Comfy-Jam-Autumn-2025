extends Control
class_name Cutscene

static var stage: int = 0
static var page: int = 0
const CONFIG: Array[Array] = [
	[
		"I can't find her anywhere...",
		"hm... not here",
		"not here either",
		"that's weird",
		"Not even here...",
		"Maybe she got out...?",
		"I should go check",
		"Hey! Wait!"
	],
	[
		"There you are!",
		"Oh, did you make a friend?",
		"Aw, how cute!",
		"Gotcha!",
		"Sorry! Has ____ been causing trouble for you?",
		"No! Not at all!"
	]
]

@onready var label: Label = $Label

func _ready() -> void:
	label.text = CONFIG[stage][page]
	await get_tree().create_timer(1).timeout
	
	page += 1
	if page < CONFIG[stage].size():
		get_tree().reload_current_scene()
	else:
		page = 0
		stage += 1
		if stage < CONFIG.size():
			get_tree().change_scene_to_file("res://map/cutscene_map.tscn")
		else:
			stage = 0
			get_tree().change_scene_to_file("res://menu/main/main.tscn")
