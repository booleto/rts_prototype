extends Node

enum rel {
	ALLY,
	HOSTILE
}

enum stat {
	ALIVE,
	DEAD,
	SPECTATOR
}


var factions : Dictionary
var faction_count = 1
var relation : Array = []
var status : PackedByteArray

func _ready():
	init_faction_data(2)
	print("relations: ", relation)
	print("statuses: ", status)

func init_faction_data(count : int):
	faction_count = count
	status.resize(faction_count)
	status.fill(stat.ALIVE)
	for i in range(faction_count):
		var relation_row = PackedByteArray()
		relation_row.resize(i + 1)
		relation_row.fill(rel.HOSTILE)
		relation_row[i] = rel.ALLY
		relation.append(relation_row)

func set_faction_status(fac : int, status : stat):
	self.status[fac] = status
	
func set_relation(fac1 : int, fac2 : int, relation : rel):
	fac1 -= 1
	fac2 -= 1
	relation[max(fac1, fac2)][min(fac1, fac2)] = relation

func is_hostile(fac1 : int, fac2 : int):
	fac1 -= 1
	fac2 -= 1
	return relation[max(fac1, fac2)][min(fac1, fac2)] == rel.HOSTILE
	
func is_friendly(fac1 : int, fac2 : int):
	return relation[max(fac1, fac2)][min(fac1, fac2)] == rel.ALLY

