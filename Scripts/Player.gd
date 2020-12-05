extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAVITY = 9.8*2
const JUMP_STRENGTH = -9.8*38
const SPEED = 9.8 * 15
var motionVector = Vector2.ZERO
var canJump = true

const stepOrderAnim = [0,1,2,3,2,1]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	motionVector.y += GRAVITY
	var result = move_and_slide_with_snap(motionVector, Vector2(0,300))
	if result.y == 0:
		canJump = true
		motionVector.y = 0
	
	
	if motionVector.x!=0 and $Timer.is_stopped():
		$Timer.start()
	elif motionVector.x==0:
		$Sprite.frame = 0
		$Timer.stop()

		
	
	pass

func _input(event):
	if Input.is_action_just_pressed("jump") and canJump:
		motionVector.y = JUMP_STRENGTH
		$jump.play()
		canJump = false
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		motionVector.x = 0
	if Input.is_action_pressed("left"):
		motionVector.x = -SPEED
		$Sprite.frame = 3
	if Input.is_action_pressed("right"):
		motionVector.x = SPEED
		$Sprite.frame = 1
		
		
func _on_Timer_timeout():
	$Sprite.frame = ($Sprite.frame + 4) % 12
	pass # Replace with function body.


