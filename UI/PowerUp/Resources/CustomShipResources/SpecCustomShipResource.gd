extends GlobalSpecResource

class_name SpecCustomShipResource

enum CUSTOM_SHIP_TYPE {
	BOOST_LIFE,
	BOOST_WEAPON,
	ADD_SHIELD,
	REDUCE_ENERGY_CONSUME
}

export (RARITY) var rarity: int = 0
export (CUSTOM_SHIP_TYPE) var custom_ship_type: int = 0
export var min_value: int = 0
export var max_value: int = 0
export var icon: Resource = null
export var description: String = ""
