class_name MemoryLocations
extends Node

var my_memory = []

enum Types
{
	CHANGE_LEVEL,
	KEY,
	RESOURCE
}

func add_memory(position, type, obj):
	var new_memory = {
		"location_x": position.x, 
		"location_y": position.y,
		"type": type,
		"obj": obj
		}
	my_memory.append(new_memory)

func get_next_key():
	for m in my_memory:
		if m.type == Types.KEY:
			return m
func get_change_of_level():
	for m in my_memory:
		if m.type == Types.CHANGE_LEVEL:
			return m
func remove_memory(obj):
	for m in my_memory:
		if m.obj == obj:
			my_memory.erase(m)
			return
