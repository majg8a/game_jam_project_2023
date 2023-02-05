extends Node2D

const Walker = preload("Walker.gd")
onready var tileMap = $TileMap
onready var player = $player
var map = []
const enemyCount = 8
var currentEnemyCount = 1
const radiusVector =  Vector2(64, 64)
onready var enemy_1 = preload("res://Scenes/enemy.tscn")

func _ready():
	generate_level()
	generate_enemies()
	
	
func generate_level():
	var walker = Walker.new(Vector2.ZERO)
	map = walker.walk(1000)
	walker.queue_free()
	
	for location in map:
		tileMap.set_cellv(location,0)
	
	var walls = walker.getWalls(map, tileMap)
	for wall in walls:
		tileMap.set_cellv(wall,1)
	
	tileMap.update()
	
	

func _on_Enemy_timer_timeout():
	generate_enemies()
		
func generate_enemies():
	if enemyCount <= currentEnemyCount:
		return
	
	var brothers = []
	
	for i in enemyCount:
		if not i == 0:
			var newEnemy = enemy_1.instance()
			var enemyPosition = int(floor((len(map) -1 )/ i))
			newEnemy.position = map[enemyPosition]*32 + Vector2(16,16)
			newEnemy.setNodeToApproach(player)
			currentEnemyCount += 1
			brothers.append(newEnemy)
	for bro in brothers:
		bro.setBorthers(brothers)
		self.add_child(bro ,false)
	
	
