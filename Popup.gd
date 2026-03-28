extends Area2D

var extra_spawned : int = 0

var popups = [
	"res://Popup/Popups/Popup0.png",
	"res://Popup/Popups/Popup1.png",
	"res://Popup/Popups/Popup2.png",
	"res://Popup/Popups/Popup3.png",
	"res://Popup/Popups/Popup4.png",
	"res://Popup/Popups/Popup5.png"
]

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$PopupContent.texture = load(popups[rng.randi_range(0, popups.size()-1)])

func _on_Popup_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		$BurstSpawn.start()
		GlobalStats.last_score = GlobalStats.score
		GlobalStats.score -= 5

func _on_TextureButton_pressed():
	if not GlobalStats.game_over:
		GlobalStats.last_score = GlobalStats.score
		GlobalStats.score += 1
		GlobalStats.popups_amount -= 1
		queue_free()

func _on_BurstSpawn_timeout():
	if extra_spawned < 6:
		get_node("/root/Main").spawn_popup()
		extra_spawned += 1
