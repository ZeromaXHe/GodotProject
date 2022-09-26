extends Node

const MapNode = preload("res://civ_like/map_node.gd")

class_name HexMap

var map: Array
var row: int
var col: int

func _init(row: int = 30, col: int = 60) -> void:
	self.row = row
	self.col = col
	self.map = []
	self.map.resize(30)
	for i in range(row):
		map[i] = []
		map[i].resize(col)
		for j in range(col):
			map[i][j] = MapNode.new(i, j)
