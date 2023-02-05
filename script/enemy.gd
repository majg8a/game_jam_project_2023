extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

var positionToApproach = Vector2()
var node = null
const speed = .8
var speedVector = Vector2(speed,speed)
var brothers = []

func _physics_process(delta):
	if node == null:
		return
	var finalPosition = node.position - position
	for bro in brothers:
		finalPosition * -bro.position
	animationPlayer.play("GolemWalk")
	move_and_slide( finalPosition)
	
func setNodeToApproach(newNode):
	node = newNode

func setBorthers(newBrothers):
	for bro in newBrothers:
		if not bro == self:
			brothers.append(bro)


func _on_Area2D_body_entered(body):
	if body.get_name() == 'Attack':
		self.visible
	
