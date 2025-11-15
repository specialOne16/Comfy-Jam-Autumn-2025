extends Control
class_name Cutscene

@onready var cutscene_music: Array[AudioStreamPlayer] = [AudioPlayer.cutscene_1, AudioPlayer.cutscene_2]

@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect_3: TextureRect = $TextureRect3

@onready var text_box: Control = $TextBox
@onready var speaker: Label = $TextBox/Speaker
@onready var text: Label = $TextBox/Text

const CONFIG: Array[Array] = [
	[
		{
			"image": preload("uid://c1x02oiy44oif"),
			"text": [
				["Serena", "Maple? Maple?"],
				["Serena", "I can’t find her anywhere…"],
				["Serena", "Hmmm. Where could she be?"],
				["Serena", "Perhaps in her cat tree?"],
			]
		},
		{
			"image": preload("uid://c7b586eqb6unb"),
			"flash_cat": preload("uid://boquhajumfj3r"),
			"text": [
				["Serena", "Huh? She’s not here…"],
				["Serena", "Where else could she be?"],
				["Serena", "Maybe she’s playing with her toys!"],
			]
		},
		{
			"image": preload("uid://c6jk85gmu0707"),
			"flash_cat": preload("uid://cldl2hpsvtqi7"),
			"text": [
				["Serena", "Not here either???"],
				["Serena", "Where is she?"],
				["Serena", "Is she mad at me? Did I forget to feed her?"],
			]
		},
		{
			"image": preload("uid://b2u3m3luygyrp"),
			"flash_cat": preload("uid://4u5q5jv5ndmc"),
			"text": [
				["Serena", "No, I definitely put food out for her."],
				["Serena", "It doesn’t look like she ate any. That’s unlike her."],
				["Serena", "Maybe she’s napping on the couch!"],
			]
		},
		{
			"image": preload("uid://dbbt3twasgitj"),
			"flash_cat": preload("uid://cjwxh5vinmol4"),
			"text": [
				["Serena", "What?"],
				["Serena", "She’s not here either?"],
				["Serena", "Did she get out somehow?"],
			]
		},
		{
			"image": preload("uid://cvnk4ojjrb8li"),
			"text": [
				["Serena", "No sign of her…"]
			]
		},
		{
			"image": preload("uid://cvnk4ojjrb8li"),
			"non_flash_cat": preload("uid://ns2jul6ucysq"),
			"text": [
				["Serena", "Wait! I see something!"]
			]
		},
		{
			"image": preload("uid://cac0cdpwfxc0t"),
			"text": [
				["Serena", "Maple?"]
			]
		},
		{
			"image": preload("uid://kvwvit3dw3vb"),
			"text": [
				["Serena", "Maple! No!"]
			]
		}
	],
	[
	]
]

const TYPING_SPEED: float = 0.05
const BLINK_SPEED: float = 0.5

var typing_speed: float = TYPING_SPEED
var blink_speed: float = BLINK_SPEED
var typing_progress = 0
var typing_target = ""
var speaker_index = 0
var text_delay = 0.7

static var stage: int = 0
static var page: int = 0
var line: int = 0

func _ready() -> void:
	typing_progress = 0
	
	var data: Dictionary = CONFIG[stage][page]
	typing_target = data.text[speaker_index][1] + "                    "
	texture_rect.texture = data.image
	texture_rect_2.texture = data.flash_cat if data.has("flash_cat") else null
	texture_rect_3.texture = data.non_flash_cat if data.has("non_flash_cat") else null
	text_box.visible = false
	
	if not cutscene_music[stage].playing:
		cutscene_music[stage].play((stage + 2) % 3)


func _process(delta: float) -> void:
	if texture_rect_2.texture:
		blink_speed -= delta
		if blink_speed < 0:
			blink_speed = BLINK_SPEED
			texture_rect_2.visible = not texture_rect_2.visible
	
	if text_delay > 0: 
		text_delay -= delta
		return
	else: 
		text_box.visible = true
	
	typing_speed -= delta
	if typing_speed < 0:
		typing_speed = TYPING_SPEED
		typing_progress += 1
	
	if typing_progress < typing_target.length() + 1:
		speaker.text = CONFIG[stage][page].text[speaker_index][0]
		text.text = typing_target.left(typing_progress)
	elif speaker_index < CONFIG[stage][page].text.size() - 1:
		speaker_index += 1
		typing_progress = 0
		typing_target = CONFIG[stage][page].text[speaker_index][1] + "                    "
	else:
		text_box.visible = false
		await get_tree().create_timer(0.7).timeout
		page += 1
		if page < CONFIG[stage].size():
			get_tree().reload_current_scene()
		else:
			cutscene_music[stage].stop()
			
			page = 0
			stage += 1
			if stage < CONFIG.size():
				get_tree().change_scene_to_file("res://map/cutscene_map.tscn")
			else:
				stage = 0
				get_tree().change_scene_to_file("res://menu/main/main.tscn")
