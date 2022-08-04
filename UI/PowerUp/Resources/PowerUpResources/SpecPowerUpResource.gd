extends GlobalSpecResource
class_name SpecPowerUpResource

enum POWERUP_TYPE {
	ADD_SHIP,
	CUSTOM_SHIP,
	ENERGY_UP
}

export (RARITY) var rarity: int = 0
export (POWERUP_TYPE) var powerup_type: int = 0
export var text: String = ""
export var image: Resource = null
