slot1 = manager.notify

slot1:RegistListener(MATERIAL_INIT, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(HERO_DATA_INIT, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(CURRENCY_UPDATE, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_MODIFY, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_MODIFIED, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(WEAPON_DATA_MODIFY, function ()
	uv0.UpdateWeaponBreakRedPoint()
end)

return {
	WeaponStr = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(46016, {
			hero_id = slot0,
			material_list = slot1,
			servant_list = slot2
		}, 46017, uv0.OnWeaponStr)
	end,
	OnWeaponStr = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponServantData:CostServantS(slot1.servant_list)
			manager.notify:CallUpdateFunc(WEAPON_STR, slot0, slot1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	WeaponBreak = function (slot0)
		manager.net:SendWithLoadingNew(46018, {
			hero_id = slot0
		}, 46019, uv0.OnWeaponBreak)
	end,
	OnWeaponBreak = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(WEAPON_BREAK, slot0, slot1)
			manager.notify:Invoke(WEAPON_DATA_MODIFY, slot1.hero_id)
		else
			ShowTips(slot0.result)
		end
	end,
	CheckLvUp = function (slot0)
		slot1 = MaterialData:GetMaterialList()
		slot2 = {}
		slot3 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		slot4 = deepClone(HeroData:GetHeroList()[slot0].weapon_info)

		if GameSetting.weapon_exp_limit.value[slot4.breakthrough + 1] <= slot4.level then
			return false
		end

		slot9 = ItemConst.ITEM_TYPE.MATERIAL

		for slot9, slot10 in ipairs(ItemCfg.get_id_list_by_type[slot9]) do
			slot12 = ItemCfg[slot10]

			if slot1[slot10] and slot12.sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and slot11.num > 0 then
				table.insert(slot2, {
					index = 0,
					select = 0,
					type = ItemConst.ITEM_TYPE.MATERIAL,
					id = slot10,
					number = slot11.num
				})
			end
		end

		table.sort(slot2, function (slot0, slot1)
			return ItemCfg[slot0.id].rare < ItemCfg[slot1.id].rare
		end)

		slot7 = GameLevelSetting[slot4.level + 1].weapon_lv_exp_sum - slot4.exp

		for slot11 = #slot2, 1, -1 do
			slot13 = ItemCfg[slot2[slot11].id].param[1]
			slot14 = 0

			while slot7 > 0 and slot14 < slot12.number do
				slot7 = slot7 - slot13
				slot14 = slot14 + 1
			end

			if slot7 < 0 and slot11 > 1 then
				slot14 = slot14 - 1
				slot7 = slot7 + slot13
			end
		end

		if slot7 > 0 then
			return false
		end

		slot8 = nil

		if slot3 < (slot4.level + 1 == slot5 and slot6 * GameSetting.weapon_strengthen_gold_cost.value[1] or (slot6 - slot7) * GameSetting.weapon_strengthen_gold_cost.value[1]) then
			return false
		end

		return true
	end,
	CheckBreak = function (slot0, slot1)
		slot2 = MaterialData:GetMaterialList()
		slot3 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		slot4 = deepClone(HeroData:GetHeroList()[slot0].weapon_info)
		slot5 = GameSetting.weapon_user_limit.value[slot4.breakthrough + 1]
		slot6 = PlayerData:GetPlayerInfo().userLevel

		if slot4.level < GameSetting.weapon_exp_limit.value[slot4.breakthrough + 1] or slot7 == HeroConst.WEAPON_LV_MAX then
			if slot1 then
				ShowTips("ERROR_HERO_WEAPON_LEVEL_LIMIT")
			end

			return false
		end

		if slot6 < slot5 then
			if slot1 then
				ShowTips("ERROR_USER_LEVEL_LIMIT")
			end

			return false
		end

		slot8, slot9 = WeaponTools.BreakMaterial(slot4.breakthrough)

		for slot13, slot14 in pairs(slot9) do
			if not slot2[slot14[1]] or slot2[slot14[1]].num < slot14[2] then
				if slot1 then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
				end

				return false
			end
		end

		if slot3 < slot8 then
			if slot1 then
				checkGold(slot8)
			end

			return false
		end

		return true
	end,
	UpdateWeaponBreakRedPoint = function ()
		if not HeroData:GetHeroList() then
			return
		end

		for slot4, slot5 in pairs(slot0) do
			slot6 = RedPointConst.HERO_WEAPON_BREAK_ID .. slot4

			if uv0.CheckBreak(slot4, false) or uv0.CheckLvUp(slot4) then
				manager.redPoint:setTip(slot6, 1)
			else
				manager.redPoint:setTip(slot6, 0)
			end
		end
	end
}
