extends Node2D

const Walker = preload("Walker.gd")
onready var tileMap = $TileMap


func _ready():
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2.ZERO)
	var map = walker.walk(10000)
	walker.queue_free()
	
	for location in map:
		tileMap.set_cellv(location,0)
	
	var walls = walker.getWalls(map, tileMap)
	for wall in walls:
		tileMap.set_cellv(wall,1)
	
	tileMap.update()
	
	
