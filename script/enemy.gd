extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

var positionToApproach = Vector2()
var node = null
const speed = .8
var speedVector = Vector2(speed,speed)
var brothers = []
var nodeExist = false 
func _physics_process(delta):
	nodeExist = is_instance_valid(node)
	var finalPosition =  node.position - position if nodeExist  else position
	animationPlayer.play("GolemWalk")
	move_and_slide( finalPosition)
	
func setNodeToApproach(newNode):
	node = newNode

func _on_Area2D_body_entered(body):
	var isPlayerAttacking = nodeExist and node.isAttacking
	if 'Player' in  body.get_name()  and isPlayerAttacking :
		queue_free()
