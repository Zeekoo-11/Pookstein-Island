extends Control

@onready var main = $"../"

var pookie_theme: String
var pookie_theme_old: String = "res://PookieTown/PookieTown.webp"
var pookie_theme_new: String = "res://PookieTown/pookieTowngenerated.png"
var theme_switched = false

func _on_resume_pressed() -> void:
	main.pauseMenu()


func _on_quit_pressed() -> void:
	get_tree().quit()

#$TextureRect.texture = ResourceLoader.load("res://PookieTown/PookieTown.webp")

func _on_change_theme_pressed() -> void:
	if theme_switched:
		pookie_theme = pookie_theme_new
		main.change_theme(pookie_theme)
		theme_switched = false
	else:
		pookie_theme = pookie_theme_old
		main.change_theme(pookie_theme)
		theme_switched = true
