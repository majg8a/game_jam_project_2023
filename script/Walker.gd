extends TileMap

const directions = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT,Vector2.DOWN]

var currentPosition = Vector2.ZERO
var direction = Vector2.RIGHT
var step_history = []
var steps_since_turn = 0

func _init(starting_position):
	currentPosition = starting_position
	step_history.append(currentPosition)
	
func walk(steps):
	for step  in steps:
		if randf() <= .25 or steps_since_turn >= 4:
			changeDirection()
		step()
		step_history.append(currentPosition)
		
	return step_history
	
func step():
	var target_position = currentPosition + direction
	steps_since_turn +=  1
	currentPosition  = target_position
		
func changeDirection():
	steps_since_turn = 0
	var newDirections  = []
	
	for x in directions:
		if not x == direction:
			newDirections.append(x)
		
	newDirections.shuffle()
	direction = newDirections[0]
	
func getWalls(floorPositions, tileMap):
	var currentPosition = Vector2.ZERO
	var wallsPositions = []
	for floorPosition in floorPositions:
		for d in directions:
			currentPosition = floorPosition + d
			if tileMap.get_cell(currentPosition.x , currentPosition.y) == tileMap.INVALID_CELL:
				wallsPositions.append(currentPosition)
	return wallsPositions
	
	
