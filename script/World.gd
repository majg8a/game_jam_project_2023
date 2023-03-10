extends Node2D

onready var enemy_1 = preload("res://Scenes/enemy.tscn")
onready var player_1 = preload("res://Scenes/player.tscn")
const Walker = preload("Walker.gd")
onready var tileMap = $TileMap
onready var player = player_1.instance()
var map = []
const enemyCount = 8
const radiusVector =  Vector2(64, 64)



func _ready():
	generate_level()
	genere_player()
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
	

func genere_player():
	player.position = map[0] * 32 + Vector2(16,16)
	self.add_child(player)

	
func _on_Enemy_timer_timeout():
	generate_enemies()
		
func generate_enemies():
	if not player:
		return
	var brothers = []
	var currentEnemies = []
	for child in self.get_children():
		if 'Golem' in  child.get_name():
			currentEnemies.append(child)
	var currentEnemyCount = len(currentEnemies)
	
	for i in enemyCount - currentEnemyCount:
		if not i == 0:
			var newEnemy = enemy_1.instance()
			var enemyPosition = int(floor((len(map) -1 )/ i))
			newEnemy.position = map[enemyPosition]*32 + Vector2(16,16)
			newEnemy.setNodeToApproach(player)
			currentEnemyCount += 1
			brothers.append(newEnemy)
			
	for bro in brothers:	
		self.add_child(bro ,false)
	
	
