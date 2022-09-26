extends Node

class_name MapNode

enum Geo {GRASS, SWAMP, WOODS, JUNGLE, DESERT, OASIS, TUNDRA, ICE}

var x: int
var y: int
var altitude: int
var geo: int

func _init(x: int, y: int, altitude: int, geo: int) -> void:
	self.x = x
	self.y = y
	self.altitude = altitude
	self.geo = geo
