extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var row: int = 9
export var col: int = 9
export var mine_count: int = 10

var sweeped_count: int = 0
var mines: Array
var sweeped: Array
var _dirs8: Array = [[-1, 1], [0, 1], [1, 1], [1, 0], [-1, 0], [-1, -1], [0, -1], [1, -1]]
var _dirs4: Array = [[0, 1], [1, 0], [-1, 0], [0, -1]]


# Called when the node enters the scene tree for the first time.
func _ready():
	mines = []
	sweeped = []
	for i in range(row):
		mines.append([])
		sweeped.append([])
		for _j in range(col):
			mines[i].append(9)
			sweeped[i].append(false)
	# init mine positions
	for _i in range(mine_count):
		var r = randi() % row
		var c = randi() % col
		while mines[r][c] == -1:
			r = randi() % row
			c = randi() % col
		mines[r][c] = -1
	# init mine neighbors
	for i in range(row):
		for j in range(col):
			if mines[i][j] == -1:
				init_mine_neighbors(i, j)
	for i in range(row):
		for j in range(col):
			if mines[i][j] == 9:
				mines[i][j] = 0
	print_2d_arr(mines)


func init_mine_neighbors(i: int, j: int) -> void:
	for dir in _dirs8:
		var ni = i + dir[0]
		var nj = j + dir[1]
		if valid(ni, nj) and mines[ni][nj] == 9:
			# counting mines around (ni, nj)
			var count = 0
			for dir2 in _dirs8:
				var ni2 = ni + dir2[0]
				var nj2 = nj + dir2[1]
				if valid(ni2, nj2) and mines[ni2][nj2] == -1:
					count += 1
			mines[ni][nj] = count


func print_2d_arr(arr: Array) -> void:
	for a in arr:
		print(a)


func valid(x: int, y: int) -> bool:
	return x >= 0 and x < row and y >= 0 and y < col


func sweep(x: int, y: int) -> int:
	sweeped[x][y] = true
	if mines[x][y] == 0:
		for dir in _dirs8:
			var nx = x + dir[0]
			var ny = y + dir[1]
			if valid(nx, ny) and not sweeped[nx][ny]:
				sweep(nx, ny)
	return mines[x][y]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
