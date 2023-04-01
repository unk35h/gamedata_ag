slot0 = {
	CURRENCY_TYPE_VITALITY = CurrencyIdMapCfg.CURRENCY_TYPE_FATIGUE.item_id,
	CURRENCY_TYPE_DRAW_TICKET = CurrencyIdMapCfg.CURRENCY_TYPE_TREASURE_TICKET.item_id,
	CURRENCY_TYPE_RMB = CurrencyIdMapCfg.CURRENCY_TYPE_MYSTICAL_DIAMOND.item_id,
	CURRENCY_TYPE_PASS = CurrencyIdMapCfg.CURRENCY_TYPE_BATTLEPASS_POINT.item_id,
	CURRENCY_TYPE_PLAYER_EXP = CurrencyIdMapCfg.CURRENCY_TYPE_USER_EXP.item_id,
	CURRENCY_TYPE_R_FRAGMENT = CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_LOW.item_id,
	CURRENCY_TYPE_SR_FRAGMENT = CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_MID.item_id,
	CURRENCY_TYPE_SSR_FRAGMENT = CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id,
	CURRENCY_TYPE_EQUIP_PIECE = CurrencyIdMapCfg.CURRENCY_TYPE_RECALL_CHAPTER.item_id,
	CURRENCY_TYPE_DRAW_EQUIP_TICKET = CurrencyIdMapCfg.CURRENCY_TYPE_TREASURE_TICKET_EQUIP.item_id,
	CURRENCY_TYPE_EQUIP_CHIP_FIVESTAR = CurrencyIdMapCfg.CURRENCY_TYPE_FIVE_STAR_EQUIP_RESOLVE.item_id,
	CURRENCY_TYPE_EQUIP_CHIP_SIXSTAR = CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id,
	CURRENCY_TYPE_NEW_RETURN_COIN = CurrencyIdMapCfg.CURRENCY_TYPE_NEW_RETURN_COIN.item_id,
	CURRENCY_TYPE_SHIFTING_EXP = CurrencyIdMapCfg.CURRENCY_TYPE_SHIFTING_EXP.item_id,
	ENOUGH_COLOR = Color.New(0.2117, 0.2274, 0.2588, 1),
	ENOUGH_COLOR_LIGHT = Color.New(0.9137, 0.9333, 0.9539, 1),
	LACK_COLOR = Color.New(0.8039, slot4, slot5, 1)
}
slot4 = 0.2588
slot5 = 0.1176

for slot4, slot5 in pairs(CurrencyIdMapCfg) do
	if slot5.id then
		slot0[slot4] = slot5.item_id
	end
end

function slot0.GetPlatformDiamondId()
	if GameToSDK.PLATFORM_ID == 1 then
		return CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS.item_id
	end

	return CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS.item_id
end

function slot0.GetOtherPlatformDiamondId()
	if GameToSDK.PLATFORM_ID == 1 then
		return CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS.item_id
	end

	return CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS.item_id
end

return slot0
