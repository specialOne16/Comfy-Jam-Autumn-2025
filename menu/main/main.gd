extends Panel


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://map/map.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/settings/settings.tscn")
