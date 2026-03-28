extends KinematicBody2D

var close_detected = false
var velocity = Vector2()

export (int) var speed = 100

func _physics_process(delta):
	#look_at(get_global_mouse_position())
	if close_detected:
		velocity = Vector2()
		velocity = Vector2(-speed, 0).rotated(rotation)
	else:
		pass
	
	velocity = move_and_slide(velocity)

func _on_Detect_body_entered(body):
	if body.name == "CloseButton":
		look_at(body.global_position)
		close_detected = true

func _on_Detect_body_exited(body):
	if body.name == "CloseButton":
		close_detected = false
