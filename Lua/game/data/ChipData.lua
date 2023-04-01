slot0 = singletonClass("ChipData")

function slot0.Init(slot0)
	slot0.enabledChipManagerID_ = 0
	slot0.unlockChipManagerIDList_ = {}
	slot0.chipManagerList_ = {}
	slot4 = ChipConst.TYPE_MANAGER

	for slot4, slot5 in ipairs(ChipCfg.get_id_list_by_type_id[slot4]) do
		slot0.chipManagerList_[slot5] = {}
	end

	slot0.unlockChipIDList_ = {}
	slot0.chipList_ = {}
	slot4 = ChipConst.TYPE_CHIP

	for slot4, slot5 in ipairs(ChipCfg.get_id_list_by_type_id[slot4]) do
		slot0.chipList_[slot5] = {}
	end

	slot0.schemeList_ = {}
	slot0.unlockHeroChip_ = {}
	slot0.enabledheroChipList_ = {}
	slot0.heroChipList_ = {}
	slot4 = ChipConst.TYPE_PERSONAL_CHIP

	for slot4, slot5 in ipairs(ChipCfg.get_id_list_by_type_id[slot4]) do
		if slot0.heroChipList_[ChipCfg[slot5].spec_char] then
			table.insert(slot0.heroChipList_[ChipCfg[slot5].spec_char], slot5)
		else
			slot0.heroChipList_[ChipCfg[slot5].spec_char] = {}

			table.insert(slot0.heroChipList_[ChipCfg[slot5].spec_char], slot5)
		end
	end

	slot0.curEnabledChipManagerID_ = nil
	slot0.curChipManagerList_ = {}
end

function slot0.InitData(slot0, slot1)
	if slot1.chip == nil then
		print("后端发送的芯片数据是空的")
	end

	slot0.enabledChipManagerID_ = slot1.chip

	for slot5, slot6 in ipairs(slot1.unlock_kernel_chip) do
		slot10 = slot6.id

		table.insert(slot0.unlockChipManagerIDList_, slot10)

		for slot10, slot11 in ipairs(slot6.secondary) do
			slot0:SetEnabledChipID(slot6.id, slot11)
		end
	end

	for slot5, slot6 in ipairs(slot1.unlock_secondary_chip) do
		table.insert(slot0.unlockChipIDList_, slot6)
	end

	for slot5, slot6 in ipairs(slot1.unlock_hero_chip) do
		table.insert(slot0.unlockHeroChip_, slot6)
	end

	for slot5, slot6 in ipairs(slot1.proposals) do
		slot7 = {}

		for slot11, slot12 in ipairs(slot6.secondary) do
			table.insert(slot7, slot12)
		end

		slot0.schemeList_[slot6.id] = {
			id = slot6.id,
			name = slot6.name,
			chipList = slot7
		}
	end

	for slot5, slot6 in ipairs(slot1.hero_chip_state) do
		slot0.enabledheroChipList_[slot6.hero_id] = {}

		for slot10, slot11 in ipairs(slot6.secondary) do
			table.insert(slot0.enabledheroChipList_[slot6.hero_id], slot11)
		end
	end
end

function slot0.SetEnabledChipManagerID(slot0, slot1)
	if slot1 == nil then
		print(debug.traceback("设置芯片数据时为空", 2))
	end

	slot0.enabledChipManagerID_ = slot1 or 0
end

function slot0.GetEnabledChipManagerID(slot0)
	return slot0.enabledChipManagerID_
end

function slot0.SetEnabledChipID(slot0, slot1, slot2)
	if table.keyof(slot0.chipManagerList_[slot1], slot2) then
		print(string.format("已经装备了芯片：", slot2))

		return
	end

	if GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot0.chipManagerList_[slot1] then
		return
	end

	table.insert(slot0.chipManagerList_[slot1], slot2)
end

function slot0.RemoveChipID(slot0, slot1, slot2)
	if table.keyof(slot0.chipManagerList_[slot1], slot2) then
		table.remove(slot0.chipManagerList_[slot1], slot3)
	end
end

function slot0.ResetChipManager(slot0, slot1)
	slot0.chipManagerList_[slot1] = {}
end

function slot0.GetChipManagerList(slot0)
	return slot0.chipManagerList_
end

function slot0.UnlockChipManager(slot0, slot1)
	table.insert(slot0.unlockChipManagerIDList_, slot1)
end

function slot0.GetUnlockChipManagerIDList(slot0)
	return slot0.unlockChipManagerIDList_
end

function slot0.GetChipList(slot0)
	return slot0.chipList_
end

function slot0.UnlockChip(slot0, slot1)
	table.insert(slot0.unlockChipIDList_, slot1)
end

function slot0.GetUnlockChipIDList(slot0)
	return slot0.unlockChipIDList_
end

function slot0.GetIsUnlockChip(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.unlockChipIDList_) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.GetSchemeList(slot0)
	return slot0.schemeList_
end

function slot0.RenameChipScheme(slot0, slot1, slot2)
	slot0.schemeList_[slot1].name = slot2
end

function slot0.DeleteChipScheme(slot0, slot1)
	slot0.schemeList_[slot1] = nil
end

function slot0.SaveChipScheme(slot0, slot1)
	slot0.schemeList_[slot1.id] = slot1
end

function slot0.GetHeroIsHaveChip(slot0, slot1)
	return slot0.heroChipList_[slot1] and true or false
end

function slot0.GetHeroChipsByHeroId(slot0, slot1)
	return slot0.heroChipList_[slot1]
end

function slot0.GetCurHeroChip(slot0, slot1)
	return slot0.enabledheroChipList_[slot1]
end

function slot0.GetUnlockHeroChipIDList(slot0)
	return slot0.unlockHeroChip_
end

function slot0.GetHeroChipIsEnableByChipId(slot0, slot1)
	for slot5, slot6 in pairs(slot0.enabledheroChipList_) do
		for slot10, slot11 in pairs(slot6) do
			if slot11 == slot1 then
				return true
			end
		end
	end

	return false
end

function slot0.UnlockHeroChip(slot0, slot1)
	table.insert(slot0.unlockHeroChip_, slot1)
end

function slot0.GetHeroChipIsEquiped(slot0, slot1, slot2)
	return slot0.enabledheroChipList_[slot1] and slot0.enabledheroChipList_[slot1][1] == slot2 or false
end

function slot0.EnableHeroChip(slot0, slot1, slot2)
	slot0.enabledheroChipList_[slot1] = {
		slot2
	}
end

function slot0.GetEnableAllChipList(slot0, slot1, slot2, slot3)
	slot4 = slot3 or {}

	if slot2 then
		for slot8, slot9 in ipairs(slot2) do
			if slot0.enabledheroChipList_[slot9] then
				for slot13, slot14 in ipairs(slot0.enabledheroChipList_[slot9]) do
					if slot14 ~= 0 then
						table.insert(slot4, slot14)
					end
				end
			end
		end
	else
		print("未传入出战英雄列表,专属芯片未传入战斗！！！！！！！！！！！！！！！")
	end

	return slot4
end

function slot0.GetEnableHeroChipIdByHeroId(slot0, slot1)
	return slot0.enabledheroChipList_[slot1]
end

function slot0.GetCurEnabledChipManagerID(slot0)
	return slot0.curEnabledChipManagerID_ and slot0.curEnabledChipManagerID_ or slot0:GetEnabledChipManagerID()
end

function slot0.SetCurEnabledChipManagerID(slot0, slot1)
	slot0.curEnabledChipManagerID_ = slot1
end

function slot0.GetCurChipManagerList(slot0, slot1)
	return slot0.curChipManagerList_[slot1] and slot0.curChipManagerList_[slot1] or slot0:GetChipManagerList()[slot1]
end

function slot0.SetCurChipManagerList(slot0, slot1, slot2)
	slot0.curChipManagerList_[slot1] = deepClone(slot2)
end

function slot0.InsertCurChipManagerList(slot0, slot1, slot2)
	ChipTools.InsertChip(slot0:GetCurChipManagerList(slot1), slot2)
end

function slot0.RemoveCurChipManagerList(slot0, slot1, slot2)
	ChipTools.RemoveChip(slot0:GetCurChipManagerList(slot1), slot2)
end

return slot0
