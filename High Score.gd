extends Label

func _process(delta):
	text = "High Score: " + str(GlobalStats.high_score)
