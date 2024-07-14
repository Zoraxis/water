extends Node

func delay(secs):
	await get_tree().create_timer(secs).timeout
	return
	
func getTime():
	return Time.get_time_dict_from_system().second

func colorCompare(color1, color2, coef):
	var r = abs(color1.r - color2.r)
	var g = abs(color1.g - color2.g)
	var b = abs(color1.b - color2.b)
	print(str(r + g + b))
	return r + g + b < coef
