extends Node

var debug = OS.is_debug_build()

var score_file = File.new()

var score : int = 0
var last_score : int
var high_score : int = 0
var popups_amount : int = 0
var can_spawn : bool = true
var game_over : bool = false
var game_paused : bool = false
var spawn_timer : int = 1

func _ready():
	load_high_score()

func _process(delta):
	if score > high_score:
		high_score = score
		save_high_score()
	
	if score < 0:
		score = 0

func save_high_score():
	score_file.open("user://highscore", File.WRITE)
	score_file.store_32(high_score)
	score_file.close()

func load_high_score():
	score_file.open("user://highscore", File.READ)
	var content = score_file.get_32()
	high_score = content
	score_file.close()
