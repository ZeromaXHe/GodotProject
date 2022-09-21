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
var buttons: Array
var _dirs8: Array = [[-1, 1], [0, 1], [1, 1], [1, 0], [-1, 0], [-1, -1], [0, -1], [1, -1]]

enum GAME_STATUS {FAILED, WON, PLAYING}

var game_status = GAME_STATUS.PLAYING


# Called when the node enters the scene tree for the first time.
func _ready():
	# 不加的话，貌似每次都是相同的种子
	randomize()
	# TODO: 不确定这里二维数组初始化有没有更好的写法？
	for i in range(row):
		mines.append([])
		sweeped.append([])
		for _j in range(col):
			mines[i].append(9)
			sweeped[i].append(false)
	init_board()
	print_board()
	print_2d_arr(mines)
	init_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_board() -> void:
	sweeped_count = 0
	game_status = GAME_STATUS.PLAYING
	for i in range(row):
		for j in range(col):
			mines[i][j] = 9
			sweeped[i][j] = false
	init_mine_positions()
	find_mine_neighbors_and_init()
	init_emptys()


func init_mine_positions() -> void:
	for _i in range(mine_count):
		var r = randi() % row
		var c = randi() % col
		while mines[r][c] == -1:
			r = randi() % row
			c = randi() % col
		mines[r][c] = -1


func find_mine_neighbors_and_init() -> void:
	for i in range(row):
		for j in range(col):
			if mines[i][j] == -1:
				init_mine_neighbors(i, j)


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


func init_emptys() -> void:
	for i in range(row):
		for j in range(col):
			if mines[i][j] == 9:
				mines[i][j] = 0


func init_buttons() -> void:
	buttons = []
	buttons.resize(row)
	for i in range(row):
		buttons[i] = []
		buttons[i].resize(col)
		for j in range(col):
			var btn: Button = Button.new()
			btn.rect_size = Vector2(50, 50)
			btn.rect_position = Vector2(100 + 50 * i, 200 + 50 * j)
			btn.connect("pressed", self, "sweep", [i, j])
			buttons[i][j] = btn
			add_child(btn)


func print_2d_arr(arr: Array) -> void:
	for a in arr:
		print(a)


func print_board() -> void:
	# TODO: 不确定这里有没有类似 StringBuilder 的优化？
	var first_line = ""
	first_line += "     "
	for j in range(col):
		first_line += "%3d " % (j + 1)
	print(first_line)
	for i in range(row):
		var line = ""
		line += "%3d |" % (i + 1)
		for j in range(col):
			if sweeped[i][j]:
				if mines[i][j] == -1:
					line += " * |"
				else:
					line += " %d |" % mines[i][j]
			else:
				line += "███|"
		print(line)


func valid(x: int, y: int) -> bool:
	return x >= 0 and x < row and y >= 0 and y < col


func sweep(x: int, y: int) -> void:
	sweeped[x][y] = true
	# 按钮更新
	var btn: Button = buttons[x][y]
	btn.disabled = true
	if(mines[x][y] > 0):
		btn.text = String(mines[x][y])
		sweeped_count += 1
	elif mines[x][y] == -1:
		btn.icon = load("res://icon.png")
		game_status = GAME_STATUS.FAILED
		print("Sorry, this is a mine! You lose")
		return
	else:
		sweeped_count += 1
		btn.modulate = Color(1, 1, 1, 1)
		# dfs
		for dir in _dirs8:
			var nx = x + dir[0]
			var ny = y + dir[1]
			if valid(nx, ny) and not sweeped[nx][ny]:
				sweep(nx, ny)
	if sweeped_count + mine_count == row * col:
		game_status = GAME_STATUS.WON
		print("Congratulations! You cleared the mine field!")


func _on_SubmitButton_pressed():
	if game_status == GAME_STATUS.WON:
		print("You have won, please restart")
		return
	if game_status == GAME_STATUS.FAILED:
		print("You have failed, please restart")
		return
	var x = $GUI/LineEditX.text.to_int()
	var y = $GUI/LineEditY.text.to_int()
	print("try to sweep x=%d, y=%d" % [x, y])
	if valid(x - 1, y - 1):
		if sweeped[x - 1][y - 1]:
			print("[%d, %d] is sweeped, please choose another area" % [x, y])
			return
		sweep(x - 1, y - 1)
		print_board()
	else:
		print("x, y not legal")


func _on_RestartButton_pressed():
	init_board()
	print_board()
	print_2d_arr(mines)
	init_buttons()
	print("game restarted...")

