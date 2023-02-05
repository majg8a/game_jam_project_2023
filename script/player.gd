extends KinematicBody2D

var speed = 200
var velocity = Vector2()

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	velocity = Vector2()
	
	
	if Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		if Input.is_action_pressed("down"):

			velocity.y += speed
			
		elif Input.is_action_pressed("up"):

			velocity.y -= speed

		if Input.is_action_pressed("left"):
			sprite.flip_h = true
			velocity.x -= speed
			
		elif Input.is_action_pressed("right"):
			sprite.flip_h = false
			velocity.x += speed
			
		animationPlayer.play("Walk")	
		
	else: 
		animationPlayer.play("idle")
		
	
	move_and_slide(velocity)
