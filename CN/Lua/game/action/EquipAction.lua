slot1 = manager.net

slot1:Bind(13009, function (slot0)
	EquipData:EquipInit(slot0.equip_list)

	if slot0.is_init == 1 then
		for slot4, slot5 in ipairs(slot0.equip_list) do
			IllustratedAction.ModifyEquipInfo(EquipCfg[slot5.prefab_id].suit, EquipCfg[slot5.prefab_id].pos)
		end
	end
end)

slot1 = nil

return {
	EquipDecompose = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot6.equip_id)
		end

		manager.net:SendWithLoadingNew(13024, {
			equip_id_list = slot1
		}, 13025, uv0.OnEquipDecompose)
	end,
	OnEquipDecompose = function (slot0, slot1)
		manager.notify:CallUpdateFunc(EQUIP_DECOMPOSE_CALLBACK, slot0, slot1)
	end,
	DeleteEquip = function (slot0)
		EquipData:DeleteEquip(slot0)
	end,
	ApplyLockEquip = function (slot0, slot1)
		if slot1 == EquipData:GetEquipData(slot0).is_lock then
			return
		end

		manager.net:SendWithLoadingNew(13016, {
			equip_id = slot0,
			is_lock = slot1 and 1 or 0
		}, 13017, uv0.OnApplyLockEquipCallBack)
	end,
	OnApplyLockEquipCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.is_lock == 1

			EquipData:ApplyLockEquipSuccess(slot1.equip_id, slot2)
			manager.notify:CallUpdateFunc(EQUIP_LOCK, slot2)
		else
			ShowTips(slot0.result)
		end
	end,
	ApplyStrengthEquip = function (slot0, slot1, slot2, slot3, slot4)
		if not checkGold(slot3) then
			return
		end

		slot5 = {}

		for slot9, slot10 in pairs(slot1) do
			table.insert(slot5, slot10.equip_id)
		end

		slot6 = {}

		for slot10, slot11 in pairs(slot2) do
			table.insert(slot6, {
				item_id = slot10,
				item_num = slot11
			})
		end

		slot7 = manager.net
		slot7 = slot7:SendWithLoading(13014, {
			equip_id = slot0,
			equip_list = slot5,
			mat_list = slot6
		}, 13015)

		return slot7:next(function (slot0)
			if isSuccess(slot0.result) then
				slot1 = EquipData
				slot2 = deepClone(slot1:GetEquipData(uv0))
				slot9 = math.floor(uv1 / GameSetting.equip_strengthen_gold_cost.value[1])

				MaterialAction.ApplyEquipStrengthSuccess(tonumber(uv0), uv2, uv3, slot9)

				slot4 = {}

				function slot5(slot0, slot1)
					for slot5, slot6 in pairs(slot1) do
						slot0[#slot0 + 1] = slot6
					end
				end

				for slot9, slot10 in pairs(uv2) do
					slot5(slot4, EquipData:GetEquipData(slot9):GetBreakCostReturn())
				end

				EquipData:ApplyEquipStrengthSuccess(tonumber(uv0), uv2, uv3, slot3)
				CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -1 * uv1)

				slot8 = EquipCfg[slot1.prefab_id]
				slot9 = slot2:GetLevel() ~= slot1:GetLevel()
				slot10 = {
					equipId = uv0,
					equip = slot1,
					oldEquip = slot2,
					newEquip = slot1,
					callback = function ()
						uv1(uv2, MaterialTools.materialGiveBack(uv0, ItemConst.STR_ITEM.EQUIP))

						uv2 = mergeReward(uv2)
						uv2 = sortReward(uv2)

						getReward(uv2)
					end
				}

				if slot1:GetLevel() < slot1:GetMaxLv() then
					slot10.pageIndex = 2

					if slot9 then
						JumpTools.OpenPageByJump("equipStrengthSuccessView", slot10)
					else
						slot10.callback()
					end
				elseif slot1.now_break_level < slot8.break_times_max then
					slot10.pageIndex = 3

					JumpTools.OpenPageByJump("equipCultureView/equipUpgradeView", slot10)
					JumpTools.OpenPageByJump("equipCultureView/equipUpgradeView/equipStrengthSuccessView", slot10)
				else
					slot10.pageIndex = 1

					JumpTools.OpenPageByJump("equipCultureView/equipDetail/equipStrengthSuccessView", slot10)
				end

				manager.notify:CallUpdateFunc(EQUIP_STRENGTH_SUCCESS)

				return
			end

			ShowTips(slot0.result)
		end)
	end,
	ApplyUpgradeEquip = function (slot0)
		slot1 = EquipData:GetEquipData(slot0)
		slot2 = slot1:GetUpgradeCost()

		if PlayerData:GetPlayerInfo().userLevel < GameSetting.equip_break_user_level.value[slot1.now_break_level + 1] then
			ShowTips("ERROR_USER_LEVEL_LIMIT")

			return
		end

		if not checkGold(slot2.money) then
			return
		end

		slot6 = MaterialData:GetMaterialList()

		for slot10 = 1, #slot2.item_list do
			if (slot6[slot2.item_list[slot10][1]] and slot6[slot2.item_list[slot10][1]].num or 0) < slot2.item_list[slot10][2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

				return
			end
		end

		slot7 = manager.net
		slot7 = slot7:SendWithLoading(13022, {
			equip_id = slot0
		}, 13023)

		return slot7:next(function (slot0)
			if isSuccess(slot0.result) then
				slot2 = deepClone(EquipData:GetEquipData(uv0))

				EquipData:ApplyUpgradeEquipSuccess(tonumber(uv0))

				slot6 = -1 * uv1.money

				CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, slot6)

				for slot6 = 1, #uv1.item_list do
					MaterialAction.MaterialModify(uv1.item_list[slot6][1], -1 * uv1.item_list[slot6][2])
				end

				JumpTools.OpenPageByJump("equipCultureView/equipStrengthView/equipUpgradeSuccessView", {
					pageIndex = 2,
					equipId = uv0,
					oldEquip = slot2,
					newEquip = slot1
				})
				ShowTips("EQUIP_BREAK_SUCCESS")
			else
				ShowTips(slot0.result)
			end
		end, function (slot0)
			print(slot0)
		end)
	end,
	EquipQuickDressOn = function (slot0, slot1)
		return manager.net:SendWithLoadingNew(13026, {
			hero_id = slot0,
			use_equip_list = slot1
		}, 13027, uv0.OnEquipQuickDressOn)
	end,
	OnEquipQuickDressOn = function (slot0, slot1)
		slot2 = true

		for slot6, slot7 in ipairs(slot0.result) do
			if not isSuccess(slot7.result) then
				slot2 = false
			end
		end

		if not slot2 then
			ShowTips(GetTips("EQUIP_DRESS_FAIL"))
		else
			manager.notify:CallUpdateFunc(EQUIP_QUICK_DRESS_ON, slot0, slot1)
		end
	end,
	QueryEquipEnchant = function (slot0, slot1, slot2, slot3)
		slot4 = slot2.id
		slot6 = slot2.number

		if not checkGold(slot2.money) then
			return
		end

		if slot6 > (MaterialData:GetMaterialList()[slot4] and slot7[slot4].num or 0) then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot4,
				slot6
			})

			return
		end

		if not (ItemCfg[slot4] and ItemCfg[slot4].param and ItemCfg[slot4].param[1]) and slot9 ~= "" then
			return
		end

		slot10 = manager.net
		slot10 = slot10:SendWithLoading(13028, {
			equip_id = slot0,
			enchant_slot_id = slot1,
			pool_id = slot9,
			lock_type = slot3
		}, 13029)

		slot10:next(function (slot0)
			if isSuccess(slot0.result) then
				MaterialAction.MaterialModify(uv0, -1 * uv1)
				EquipData:AddPreEnchant(uv2, uv3, slot0.enchant_preview)
				CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -1 * uv4)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipEnchantConfirm = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net
		slot4 = slot4:SendWithLoading(13030, {
			equip_id = slot0,
			enchant_slot_id = slot1,
			confirm = slot2,
			preview_index = slot3
		}, 13031)

		return slot4:next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:ConfirmEnchant(uv0, uv1, uv2, uv3)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT_CONFIRM, uv2)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipGiveUpAllEnchant = function (slot0, slot1)
		slot2 = manager.net
		slot2 = slot2:SendWithLoading(13044, {
			equip_id = slot0,
			enchant_slot_id = slot1
		}, 13045)

		return slot2:next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:GiveUpAllEnchant(uv0, uv1)
				manager.notify:CallUpdateFunc(EQUIP_ENCHANT_GIVE_UP)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipRace = function (slot0, slot1, slot2)
		slot3 = EquipData:GetRaceMaterial(slot1)
		slot4 = slot3.id
		slot6 = slot3.number

		if not checkGold(slot3.money) then
			return
		end

		if slot6 > (MaterialData:GetMaterialList()[slot4] and slot7[slot4].num or 0) then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot4,
				slot6
			})

			return
		end

		slot9, slot10 = nil
		slot11 = {
			equip_id = slot0
		}

		if slot1 == 1 then
			slot9 = 13032
			slot10 = 13033
		else
			slot9 = 13046
			slot10 = 13047
			slot11.hero_id = slot2
		end

		slot12 = manager.net
		slot12 = slot12:SendWithLoading(slot9, slot11, slot10)

		slot12:next(function (slot0)
			if isSuccess(slot0.result) then
				MaterialAction.MaterialModify(uv0, -1 * uv1)
				CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -1 * uv2)

				if uv3 == 2 then
					EquipData:SetPreRace(uv4, uv5)
					EquipData:ConfirmRace(uv4, true)

					if not EquipData:GetEquipData(uv4).is_lock then
						EquipAction.ApplyLockEquip(uv4, true)
					end

					ShowTips("EQUIP_HERO_SUCCESS")
				else
					EquipData:SetPreRace(uv4, slot0.race_preview)
					JumpTools.OpenPageByJump("/equipRaceConfirmView", {
						equipId = uv4
					})
				end

				manager.notify:CallUpdateFunc(EQUIP_RACE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryEquipRaceConfirm = function (slot0, slot1)
		slot2 = manager.net
		slot2 = slot2:SendWithLoading(13034, {
			equip_id = slot0,
			confirm = slot1
		}, 13035)

		slot2:next(function (slot0)
			if isSuccess(slot0.result) then
				EquipData:ConfirmRace(uv0, uv1)
				manager.notify:CallUpdateFunc(EQUIP_RACE_CONFIRM)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	EquipBagFull = function (slot0)
		EquipData:EquipBagFull(slot0)
	end,
	InheritEquip = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(13052, {
			inherit_equip_prefab_id = slot1,
			new_equip_id = slot0
		}, 13053, uv1.OnInheritEquip)
	end,
	OnInheritEquip = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("EQUIP_INHERIT_SUCCESS")

			slot3, slot4 = EquipData:GetInheritCost(EquipCfg[uv0].suit)
			slot8 = -1 * slot4

			CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, slot8)

			for slot8, slot9 in ipairs(slot3) do
				slot11 = slot9.number

				if ItemCfg[slot9.id].type == ItemConst.ITEM_TYPE.MATERIAL then
					MaterialAction.MaterialModify(slot10, -1 * slot11)
				elseif slot12 == ItemConst.ITEM_TYPE.CURRENCY then
					CurrencyAction.CurrencyModify(slot10, -1 * slot11)
				end
			end

			manager.notify:CallUpdateFunc(EQUIP_INHERIT_SUCCESS, slot1.new_equip_id)
		else
			ShowTips(slot0.result)
		end
	end
}
