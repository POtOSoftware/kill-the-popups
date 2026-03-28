extends ProgressBar

var rng = RandomNumberGenerator.new()
var popups = []
var popup_to_delete

var window = JavaScript.get_interface("window")

func _ready():
	rng.randomize()

func _process(delta):
	value = GlobalStats.popups_amount
	
	# Game Over
	if value == max_value and !GlobalStats.game_over:
		GlobalStats.can_spawn = false
		$DeleteTimer.start()
		# Create a list of popups to delete
		popups.append_array(get_tree().get_nodes_in_group("popup"))
		GlobalStats.game_over = true
		$"../../BGMusic".playing = false
		$"../../GameOverSFX".play()
		GlobalStats.score_file.flush()
		window.alert("Giggity")
		#get_tree().quit()

# Every hundredth of a second, delete a popup for that cool effect
func _on_DeleteTimer_timeout():
	# If the amount of popups in the list is not zero
	if popups.size() != 0:
		# Choose a random popup from the list (jump to line 33 for next step)
		popup_to_delete = popups[rng.randi_range(0, popups.size()-1)]
	# If the amount of popups is zero
	if popups.size() == 0:
		# Show the game over text and stop the delete timer
		$"../Game Over".visible = true
		$DeleteTimer.stop()
	# Then delete the chosen popup
	get_node("/root/Main/PopupLayer").remove_child(popup_to_delete)
	# And remove the deleted popup from the list
	popups.erase(popup_to_delete)
	#print(get_node("/root/Main/PopupsLayer"))
