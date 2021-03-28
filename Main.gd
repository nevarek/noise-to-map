extends Node2D

func _ready():
	$TileMap.generate_map()

func _input(event):
	if event.is_action_released('new_map'):
		$TileMap.generate_map()
