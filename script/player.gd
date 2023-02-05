extends KinematicBody2D

var speed = 200
var velocity = Vector2()
onready var attack = $Attack.get_child(0)
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var muelto = false

func _physics_process(delta):
	if muelto:
		return
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
	elif Input.is_action_pressed("ui_accept"):
		animationPlayer.play("Attack")
		attack.disabled = false
		
	else: 
		animationPlayer.play("idle")
		attack.disabled = true
	move_and_slide(velocity)
	
	

func _on_Area2D_body_entered(body):
#	if "Golem" in body.get_name():
#		visible = false
#		muelto = true
	pass
