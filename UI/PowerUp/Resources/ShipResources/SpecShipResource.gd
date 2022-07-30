extends Resource
class_name SpecShipResources

enum RARITY {
	LEGENDARY,
	SUPER_RARE,
	EXTRAORDINARY,
	RARE,
	COMMON
}

export (RARITY) var rarity = 0
export var ship_scene: Resource = null
export var name: String = ""
export var image: Resource = null
