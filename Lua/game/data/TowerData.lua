slot0 = singletonClass("TowerData")
slot1 = -1
slot2 = {}

function slot0.Init(slot0)
	uv0 = -1
	uv1 = {}
end

function slot0.InitTowerData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.area] = slot6.stage
	end
end

function slot0.UpdateOverTower(slot0, slot1, slot2)
	if not uv0[slot1] then
		uv0[slot1] = slot2
	else
		uv0[slot1] = Mathf.Max(uv0[slot1], slot2)
	end
end

function slot0.GetCurId(slot0, slot1)
	slot2 = ChapterCfg[slot1].section_id_list

	return slot2[(uv0[slot1] and table.indexof(slot2, slot3) or 0) + 1]
end

function slot0.GetOverId(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetTowerList(slot0, slot1)
	return ChapterCfg[slot1].section_id_list
end

function slot0.GetTowerMaxId(slot0)
	slot1 = 0

	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if slot1 < slot6 then
				slot1 = slot6 or slot1
			end
		end
	end

	return slot1
end

function slot0.ReverseTable(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		slot2[slot6] = slot1[#slot1 + 1 - slot6]
	end

	return slot2
end

function slot0.GetAllTowerList(slot0)
	return BattleTowerStageCfg.all
end

function slot0.CacheTowerStageViewScrollPos(slot0, slot1)
	slot0.towerStageViewScrollPos_ = slot1
end

function slot0.GetTowerStageViewScrollPos(slot0)
	return slot0.towerStageViewScrollPos_
end

return slot0
