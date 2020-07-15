extends KinematicBody2D


const WALK_SPEED = 500
const JUMP_SPEED = 1000
const GRAVITY = 50

var motion = Vector2()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	gravity()
	jump()
	walk()
	animate()
	move_and_slide(motion, Vector2.UP)
	pass
	
func gravity():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED

func walk():
	var SPEED = 0
	if Input.is_action_pressed('right'):
		SPEED += WALK_SPEED
	if Input.is_action_pressed('left'):
		SPEED -= WALK_SPEED
	motion.x = SPEED

func animate():
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
	elif motion.x < 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
