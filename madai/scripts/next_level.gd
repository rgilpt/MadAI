extends StaticBody2D


@export var requirements = [{"name":"Key", "quantity": 3}]

@export_file() var target = ""

func check_requirements(input):
	var total_fullfillment = requirements.size()
	var check_requirements = requirements.duplicate(true)
	for r in check_requirements:
		for i in input:
			if i["name"] == r["name"]:
				r["quantity"] -= 1
			if r.quantity == 0:
				total_fullfillment = 0
				
				
	if total_fullfillment == 0:
		return true
	else:
		return false
