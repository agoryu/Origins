extends GlobalSpecResource
class_name SpecPowerUpResource

enum POWERUP_TYPE {
	ADD_SHIP,
	CUSTOM_SHIP
}

export (RARITY) var rarity: int = 0
export (POWERUP_TYPE) var powerup_type: int = 0
export var card : Resource = null
