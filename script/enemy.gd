extends KinematicBody2D

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
	move_and_slide( finalPosition)
	
func setNodeToApproach(newNode):
	node = newNode

func setBorthers(newBrothers):
	for bro in newBrothers:
		if not bro == self:
			brothers.append(bro)
