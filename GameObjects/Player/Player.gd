extends KinematicBody2D

# Member variables

export(int) var HORIZONTAL_SPEED 
export(float) var GRAVITY
export(int) var JUMP_FORCE

var motion = Vector2.ZERO

func _physics_process(delta):

	# calculating and applying vertical vector

	proccess_jump_input()

	motion.y += GRAVITY * delta

	# calculating and applying horizontal vector

	proccess_move_input()

	motion = move_and_slide(motion) 

func proccess_jump_input():
	if Input.is_action_just_pressed("ui_accept"):
		motion.y -= JUMP_FORCE
	
	if Input.is_action_just_released("ui_accept"):
		if motion.y < 0:
			motion.y = 0
			motion.y -= JUMP_FORCE/2
	
func proccess_move_input():
	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.x = input_direction * HORIZONTAL_SPEED