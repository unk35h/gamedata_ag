return {
	DORM_VISIT_PRIVATE = 1002,
	WALL_TYPE_NUM = 21,
	FLOOR_ORI_ID = 951014,
	CANTEEN_ID = 4,
	DORM_VISIT_LOBBY = 1001,
	LOBBY_ORI_WALL_ID = 961002,
	POS_PRECISION = 1000,
	DISPATCH_REFRESH_TIME = 1,
	ORDER_FOOD_AUTO_NUM = 1,
	PRIVATE_CHARACTER_MAX_NUM = 1,
	COOK_CURSOR_FRAME = 30,
	DORM_FUR_TYPE_START = 20,
	WALL_ORI_ID = 951013,
	DORM_FUR_TYPE_END = 26,
	CATEEN_ORDER_FOOD_LIST_NUM = 3,
	DORM_HERO_TAG_MAX = 20,
	FLOOR_TYPE_NUM = 20,
	LOAD_WARING_NUM = 0.9,
	DORM_PRIVATE_FIRST_ID = 6,
	DORM_POS_ID_OFFSET = 100,
	LOBBY_ORI_FLOOR_ID = 961001,
	LOAD_HIGH_NUM = 0.8,
	CANTEEN_TRUST_CHARACTER_NUM = 3,
	PUBLIC_DORM_ID = 5,
	CANTEEN_FOOD_MATERIAL_PATH = "Textures/EmptyDream/canteen/material/",
	ORDER_FOOD_NUM = 2,
	CANTEEN_FOOD_PATH = "Textures/EmptyDream/canteen/food/",
	CHARACTER_INTERACT_CAMERA_MOVE_TIME = 0.5,
	TILE_TYPE = {
		CEIL = 1,
		FLOOR = 0,
		WALL_FRONT = 2,
		WALL_RIGHT = 5,
		WALL_BEHIND = 3,
		WALL_LEFT = 4
	},
	DORM_HERO_SKILL_SUB_TYPE = {
		ADD_EANRNINGS_IN_ARCHITECTURE = 101,
		ADD_EANRNINGS_WITH_HERO_IN_ARCHITECTURE = 103,
		REDUCE_MOODE_IN_ARCHITECTURE = 202,
		REDUCE_MOOD_MYSELF_IN_ARCHITECTURE = 201,
		ADD_GOODS_EARNINGS = 102
	},
	DORM_HERO_MAX_MOOD = GameSetting.dorm_hero_mood_max.value[1],
	DORM_RESTAURANT_SET_JOB_TYPE = {
		"RestaurantCashier",
		"RestaurantWaiter",
		"RestaurantCook"
	},
	BACKHOME_TYPE = {
		PrivateDorm = 3,
		VISITPRIVATEDORM = 5,
		VISITPUBLICDORM = 4,
		PublicDorm = 2,
		Canteen = 1
	},
	BACKHOME_FUR_GIVE_TYPE = {
		GIFT = 1,
		NO_GIFT = 0,
		SPECIFY = 3
	},
	DORM_TEMPLATE_NUM_MAX = GameSetting.dorm_template_max.value[1],
	DORM_TEMPLATE_PRIVATE_NUM_MAX = GameSetting.dorm_template_max.value[1],
	DORM_FLOOR_MAX = GameDisplayCfg.dorm_area_layer_num.value[1],
	DORM_FLOOR_ROOM_NUM = GameDisplayCfg.dorm_area_room_max.value[1],
	DORM_AUDIO_EFFECT = {
		ChangeFloor = "ui_dorm_position",
		UpCharacter = "ui_dorm_up",
		InteractCam = "ui_dorm_character",
		PlaceFur = "ui_dorm_furniture",
		DownCharacter = "ui_dorm_down"
	},
	DORM_FUR_TYPE_RED_POINT = {
		[24.0] = "DORM_FURNITURE_BED",
		[25.0] = "DORM_FURNITURE_FLOOR_ITEM",
		[26.0] = "DORM_FURNITURE_WALL_ITEM",
		[23.0] = "DORM_FURNITURE_TABLE",
		[20.0] = "DORM_FURNITURE_FLOOR",
		[21.0] = "DORM_FURNITURE_WALL",
		[22.0] = "DORM_FURNITURE_WINDOW"
	},
	DORM_FUR_EDITVIEW_TYPE = {
		HadPlace = "HadPlace",
		CanPlace = "CanPlace",
		OtherHadPlace = "OtherHadPlac",
		NotPresented = "NotPresented"
	}
}
