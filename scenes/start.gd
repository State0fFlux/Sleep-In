extends Control

func _on_quit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().quit()

func _on_wake_up_button_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scenes/bedroom.tscn")

func _on_options_button_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scenes/options.tscn")

func _on_meet_the_devs_button_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scenes/creds.tscn")
