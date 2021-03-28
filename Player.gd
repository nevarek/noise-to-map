extends KinematicBody2D

const ZOOM_STEP = Vector2(0.2, 0.2)

export (int) var speed = 1200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed * get_zoom_factor()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _input(event):
	if event.is_action_released('zoom_out'):
		$Camera2D.zoom += ZOOM_STEP
		clamp_zoom()
	if event.is_action_released('zoom_in'):
		$Camera2D.zoom -= ZOOM_STEP
		clamp_zoom()

func clamp_zoom():
	$Camera2D.zoom.x = clamp($Camera2D.zoom.x, 1.6, 5)
	$Camera2D.zoom.y = $Camera2D.zoom.x

func get_zoom_factor():
	return $Camera2D.zoom.x / 2
