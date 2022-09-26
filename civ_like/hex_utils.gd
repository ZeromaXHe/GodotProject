extends Node

class_name HexUtils


class HexOddr:
	var r: int
	var c: int
	
	func _init(r: int, c: int) -> void:
		self.r = r
		self.c = c
	
	
	func _to_string() -> String:
		return "[%d, %d]" % [r, c]


class HexAxial:
	var q: int
	var r: int
	
	func _init(q: int, r: int) -> void:
		self.q = q
		self.r = r
	
	
	func _to_string() -> String:
		return "[%d, %d]" % [q, r]


const oddr_dir_diff = [
	# even rows
	[[1, 0], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1]],
	# odd rows
	[[1, 0], [1, -1], [0, -1], [-1, 0], [0, 1], [1, 1]]
]


static func get_neighbors(hex: HexOddr) -> Array:
	var parity = hex.r & 1
	var diffs = oddr_dir_diff[parity]
	var res = []
	for diff in diffs:
		var nr = hex.r + diff[0]
		var nc = hex.c + diff[1]	
		res.append(HexOddr.new(nr, nc))
	return res


static func axial_to_oddr(hex: HexAxial) -> HexOddr:
	var col = hex.q + (hex.r - (hex.r & 1)) / 2
	var row = hex.r
	return HexOddr.new(col, row)


static func oddr_to_axial(hex: HexOddr) -> HexAxial:
	var q = hex.c - (hex.r - (hex.r & 1)) / 2
	var r = hex.r
	return HexAxial.new(q, r)
	
	
static func oddr_distance(a: HexOddr, b: HexOddr) -> int:
	var ac = oddr_to_axial(a)
	var bc = oddr_to_axial(b)
#	print("ac: %s" % ac)
#	print("bc: %s" % bc)
	return axial_distance(ac, bc)


static func axial_distance(a: HexAxial, b: HexAxial) -> int:
	return int((abs(a.q - b.q) + abs(a.q + a.r - b.q - b.r) + abs(a.r - b.r)) / 2)
