slot0 = singletonClass("BattleEquipData")
slot1 = {
	upSuitId = 0,
	baseStageId = 0,
	guaranteeNum = {}
}

function slot0.InitBattleEquipData(slot0, slot1)
	uv0.baseStageId = slot1.stage_base_id
	uv0.upSuitId = slot1.equip_suit_id
	uv0.next_refresh_time = slot1.next_refresh_time

	for slot5, slot6 in ipairs(slot1.insure_list) do
		uv0.guaranteeNum[slot6.difficulty] = slot6.insure_times
	end
end

function slot0.ChangeUpSuitId(slot0, slot1)
	uv0.upSuitId = slot1
end

function slot0.SetGuaranteeNum(slot0, slot1, slot2)
	uv0.guaranteeNum[slot1] = slot2
end

function slot0.AddGuaranteeNum(slot0, slot1, slot2)
	uv0.guaranteeNum[slot1] = (uv0.guaranteeNum[slot1] or 0) + slot2
end

function slot0.GetBattleEquipData(slot0)
	return uv0
end

function slot0.GetGuaranteeNum(slot0)
	return uv0.guaranteeNum
end

return slot0
