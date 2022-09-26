extends Node

func _ready() -> void:
	print(HexUtils.get_neighbors(HexUtils.HexOddr.new(0,0)))
	print(HexUtils.oddr_distance(HexUtils.HexOddr.new(0,0), HexUtils.HexOddr.new(1,0))) # 1
	print(HexUtils.oddr_distance(HexUtils.HexOddr.new(0,0), HexUtils.HexOddr.new(2,1))) # 2
	print(HexUtils.oddr_distance(HexUtils.HexOddr.new(0,0), HexUtils.HexOddr.new(3,1))) # 3
	print(HexUtils.oddr_distance(HexUtils.HexOddr.new(0,0), HexUtils.HexOddr.new(4,2))) # 4
	print(HexUtils.oddr_distance(HexUtils.HexOddr.new(0,0), HexUtils.HexOddr.new(5,2))) # 5
