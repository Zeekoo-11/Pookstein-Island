extends Node

const SAVE_FILE_PATH = "user://savedata.save"
@export var mob_scene: PackedScene
var score = 0
var high_score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_game()
	$HUD.update_high_score(high_score)
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
func new_game():
	get_tree().call_group("mobs", "queue_free")
	if score > high_score:
		high_score = score
		$HUD.update_high_score(high_score)
		save_game()
	score = 0
	$MobTimer.wait_time = 0.5
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(200.0, 350.0), 0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)
	if score == 10:
		$MobTimer.wait_time = 0.4
	elif score == 15:
		$MobTimer.wait_time = 0.35
	elif score == 20:
		$MobTimer.wait_time = 0.3
	elif score == 25:
		$MobTimer.wait_time = 0.25


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	
func save_game():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_var(high_score)
	save_data.close()
	
func load_game():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		high_score = save_data.get_var()
		save_data.close()
