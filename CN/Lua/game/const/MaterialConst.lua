return {
	GUILD_ACTIVITY_COIN = 53008,
	MATERIAL_TYPE = {
		EQUIP_LEVEL_UP = 608,
		OHTER_2 = 604,
		MYTHIC_REFRESH = 611,
		WEAPON_LEVEL_UP = 602,
		OHTER_1 = 603,
		HERO_LEVEL_UP = 601
	},
	DecorateToTitleBar = function (slot0)
		return "mat_" .. slot0
	end,
	MYTHIC_REFRESH_ITEM_ID = ItemCfg.get_id_list_by_sub_type[611][1]
}
