extends Node2D

var music = [
	"res://Music/BGMusic01.ogg",
	"res://Music/BGMusic02.ogg",
	"res://Music/BGMusic03.ogg",
	"res://Music/BGMusic04.ogg",
	"res://Music/BGMusic05.ogg"
]

var popup = preload("res://Popup.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	$SpawnTimer.wait_time = GlobalStats.spawn_timer
	
	rng.randomize()
	GlobalStats.score = 0
	
	$BGMusic.stream = load(str(music[rng.randi_range(0, music.size()-1)]))
	$BGMusic.playing = true

func _process(delta):
	if GlobalStats.debug:
		if Input.is_action_just_pressed("debug_add_score"):
			GlobalStats.score += 1
			GlobalStats.last_score = GlobalStats.score
		if Input.is_action_just_pressed("debug_subtract_score"):
			GlobalStats.score -= 1
			GlobalStats.last_score = GlobalStats.score
	
	if Input.is_action_just_pressed("click"):
		$ClickSFX.play()
	
	$PauseLayer/ColorRect.visible = GlobalStats.game_paused

func _unhandled_key_input(event):
	if GlobalStats.game_over:
		GlobalStats.can_spawn = true
		GlobalStats.popups_amount = 0
		GlobalStats.game_over = false
		get_tree().reload_current_scene()

func spawn_popup():
	if GlobalStats.can_spawn:
		var popup_instance = popup.instance()
		# The random values are super specific so the X button doesn't show up outside of the screen
		popup_instance.position = Vector2(rng.randi_range(1, 1104),rng.randi_range(112, 720))
		# Create a popup as a child of the popup layer
		$PopupLayer.add_child(popup_instance)
		GlobalStats.popups_amount += 1

func _on_SpawnTimer_timeout():
	# it no workey :(
	#if GlobalStats.score % 10 == 0:
	#	if not GlobalStats.score == GlobalStats.last_score:
	#		$SpawnTimer.wait_time -= .1
	spawn_popup()
	#print($SpawnTimer.wait_time)

func _on_Start_Button_pressed():
	GlobalStats.game_paused = not GlobalStats.game_paused
	GlobalStats.score_file.flush()
	if not GlobalStats.game_over:
		$BGMusic.playing = not GlobalStats.game_paused
		GlobalStats.can_spawn = not GlobalStats.can_spawn
