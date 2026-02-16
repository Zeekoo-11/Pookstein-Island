extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$MarginContainer/Panel/Message.text = text
	$MarginContainer.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await get_tree().create_timer(1.0).timeout
	$MarginContainer/Panel/Message.text = "Dodge the Pookies"
	$MarginContainer.show()

	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_high_score(high_score):
	$HighScore.text = str(high_score)
	


func _on_message_timer_timeout() -> void:
	$MarginContainer.hide()


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
