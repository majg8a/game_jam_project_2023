extends KinematicBody2D

var speed = 200
var velocity = Vector2()
onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var muelto = false
onready var isAttacking = false

func _physics_process(delta):
	if muelto:
		return
	
	if not Input.is_action_pressed("ui_accept"):
		isAttacking = false
		
	if move() and not isAttacking:
		animationPlayer.play("Walk")	
	elif Input.is_action_pressed("ui_accept"):
		animationPlayer.play("Attack")
		isAttacking = true
	else: 
		animationPlayer.play("idle")
		
	move_and_slide(velocity)
	
	
func move():
	velocity = Vector2()
	var isMoving = Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right")
	if isMoving:
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
		return isMoving

func _on_Area2D_body_entered(body):
	if "Golem" in body.get_name() and not isAttacking:
		queue_free()
		get_tree().change_scene("res://Scenes/Menu.tscn")
