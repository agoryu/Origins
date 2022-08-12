extends Node

class_name GlobalManager

var nb_rarity = 0

func _init():
	nb_rarity = GlobalSpecResource.RARITY.size()
	
# Calculate score for determination of rarity of object
func calculate_score_value(value_bonus: float, min_value: float, max_value: float) -> int:
	var step = (max_value - min_value) / float(GlobalSpecResource.RARITY.size())
	for i in nb_rarity - 1:
		if value_bonus >= min_value + ((nb_rarity - i) * step):
			return nb_rarity - i - 1
	return 0

func calculate_color_rarity(rarity: int) -> Color:
	match rarity:
		GlobalSpecResource.RARITY.COMMON:
			print("blue")
			return Color("#179cd0")
		GlobalSpecResource.RARITY.RARE:
			print("green")
			return Color("#3fd017")
		GlobalSpecResource.RARITY.SUPER_RARE:
			print("yellow")
			return Color("#d0c917")
		GlobalSpecResource.RARITY.EXTRAORDINARY:
			print("orange")
			return Color("#d07b17")
		GlobalSpecResource.RARITY.LEGENDARY:
			print("violet")
			return Color("#9755da")
	return Color(1)
