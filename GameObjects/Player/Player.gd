extends KinematicBody2D

# Child Nodes

onready var magnet_area = $MagnetArea

# Member variables

export(int) var HORIZONTAL_SPEED 
export(float) var GRAVITY
export(int) var JUMP_FORCE

var motion = Vector2.ZERO

func _physics_process(delta):

	proccess_player_movement(delta)

	motion = move_and_slide(motion, Vector2.UP) 

func proccess_player_movement(delta):
	proccess_jump_input()
	proccess_gravity(delta)
	proccess_move_input()
	proccess_magnet_force()

func proccess_jump_input():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			motion.y -= JUMP_FORCE
		
		if Input.is_action_just_released("ui_accept"):
			if motion.y < 0:
				motion.y = 0
				motion.y -= JUMP_FORCE/2
	
func proccess_move_input():
	var input_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.x = input_direction * HORIZONTAL_SPEED

func proccess_gravity(delta):
	motion.y += GRAVITY * delta

func proccess_magnet_force():
	if Input.is_action_pressed("magnet"):
		var bodies = magnet_area.get_overlapping_bodies()

		for body in bodies:
			if body.name == "Magnet":
				
				var body_position = body.get_global_position()
				var player_position = get_global_position()

				var magnet_force_direction = body_position - player_position

				motion += magnet_force_direction.normalized() * 10

				if motion.y < -150:
					motion.y = -150
				
				if motion.y > 150:
					motion.y = 150
				
