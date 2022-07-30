extends Resource

class_name SpecCustomShipResource

enum RARITY {
	SUPER_RARE,
	RARE,
	COMMON
}

enum CUSTOM_SHIP_TYPE {
	BOOST_LIFE,
	BOOST_WEAPON,
	ADD_SHIELD,
	REDUCE_ENERGY_CONSUME
}

export (RARITY) var rarity: int = 0
export (CUSTOM_SHIP_TYPE) var custom_ship_type: int = 0
export var text: String = ""
export var min_value: int = 0
export var max_value: int = 0
var ship: Character = null
var value: int = 0
