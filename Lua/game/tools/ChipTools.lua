return {
	SortChipManager = function (slot0)
		slot2 = {}
		slot3 = {}
		slot4 = {}
		slot5 = ChipData:GetUnlockChipManagerIDList()

		for slot9, slot10 in pairs(ChipData:GetChipManagerList()) do
			if slot9 ~= slot0 then
				if table.keyof(slot5, slot9) then
					table.insert(slot2, slot9)
				elseif IsConditionAchieved(ChipCfg[slot9].new_condition) then
					table.insert(slot3, slot9)
				else
					table.insert(slot4, slot9)
				end
			end
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.sort(slot3, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.sort(slot4, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.insertto(slot2, slot3)
		table.insertto(slot2, slot4)

		if slot0 ~= 0 then
			table.insert(slot2, 1, slot0)
		end

		if manager.guide:IsPlaying() and table.indexof(slot2, 6) then
			table.remove(slot2, slot6)
			table.insert(slot2, 1, 6)
		end

		return slot2
	end,
	SortChip = function (slot0, slot1)
		return uv0.SortChipList(ChipData:GetChipManagerList()[slot1], slot0, slot1)
	end,
	SortChipList = function (slot0, slot1, slot2, slot3)
		slot4 = {}
		slot5 = {}
		slot6 = {}
		slot7 = {}
		slot8 = nil
		slot8 = (not slot3 or ChipData:GetUnlockHeroChipIDList()) and ChipData:GetUnlockChipIDList()

		for slot12, slot13 in pairs(slot1) do
			if not table.keyof(slot0, slot13) then
				if table.keyof(slot8, slot13) then
					table.insert(slot5, slot13)
				elseif IsConditionAchieved(ChipCfg[slot13].new_condition) then
					table.insert(slot6, slot13)
				else
					table.insert(slot7, slot13)
				end
			else
				table.insert(slot4, slot13)
			end
		end

		uv0.SortRegular(slot5)
		uv0.SortRegular(slot6)
		uv0.SortRegular(slot7)
		table.insertto(slot4, slot5)
		table.insertto(slot4, slot6)
		table.insertto(slot4, slot7)

		return slot4
	end,
	SortRegular = function (slot0)
		table.sort(slot0, function (slot0, slot1)
			slot3 = ChipCfg[slot1].spec_char

			if ChipCfg[slot0].spec_char ~= 0 and slot3 == 0 then
				return false
			end

			return slot0 < slot1
		end)
	end,
	GetChipTypeList = function (slot0)
		slot1 = {
			-1,
			0
		}
		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			if not table.keyof(slot2, ChipCfg[slot7].spec_char) and slot8 ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		table.insertto(slot1, HeroTools.SortHero(slot2))

		return slot1
	end,
	GetChipTypeCntList = function (slot0)
		slot1 = {
			[-1] = {}
		}

		for slot5, slot6 in ipairs(slot0) do
			slot1[slot7] = slot1[ChipCfg[slot6].spec_char] or {}

			table.insert(slot1[slot7], slot6)
			table.insert(slot1[-1], slot6)
		end

		return slot1
	end,
	SortScheme = function (slot0)
		slot3 = {
			{
				id = 0,
				name = GetTips(slot7),
				chipList = ChipData:GetChipManagerList()[slot0]
			}
		}
		slot7 = "CURRENT_SCHEME"

		for slot7, slot8 in pairs(ChipData:GetSchemeList()) do
			slot9 = #slot1 == #slot8.chipList

			for slot13, slot14 in ipairs(slot8.chipList) do
				if not table.keyof(slot1, slot14) then
					slot9 = false

					break
				end
			end

			if slot9 then
				slot3[1] = clone(slot8)
			else
				table.insert(slot3, clone(slot8))
			end
		end

		for slot7 = #slot3 + 1, GameSetting.ai_chip_proposal_num_max.value[1] do
			table.insert(slot3, {
				id = -1
			})
		end

		return slot3
	end,
	InsertChip = function (slot0, slot1)
		slot2 = false
		slot3 = 0
		slot5 = ChipCfg.get_id_list_by_spec_char[ChipCfg[slot1].spec_char]

		for slot9, slot10 in ipairs(slot0) do
			if ChipCfg[slot10].spec_char ~= 0 and table.keyof(slot5, slot10) and slot10 ~= slot1 then
				slot2 = true
				slot3 = slot10

				break
			end
		end

		if not table.indexof(slot0, slot1) and not slot2 and GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot0 then
			ShowTips("CHIP_CNT_MORE_THEN_MAX")

			return
		end

		if slot2 and table.indexof(slot0, slot3) then
			table.remove(slot0, slot6)
		end

		table.insert(slot0, slot1)
		ShowTips("CHIP_USE_SUCCESS")
		manager.notify:Invoke(ENABLED_CHIP)
	end,
	RemoveChip = function (slot0, slot1)
		if table.indexof(slot0, slot1) then
			table.remove(slot0, slot2)
		end

		ShowTips("CHIP_UNLOAD_SUCCESS")
		manager.notify:Invoke(ENABLED_CHIP)
	end
}
