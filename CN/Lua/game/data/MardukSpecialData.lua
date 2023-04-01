slot0 = singletonClass("MardukSpecialData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitDataFromServer(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot1.activity_id] = {}
	end

	uv0[slot1.activity_id].activity_id = slot1.activity_id
	uv0[slot1.activity_id].point = slot1.point
	uv0[slot1.activity_id].got_reward_id_list = {}

	for slot5, slot6 in ipairs(slot1.got_reward_id_list) do
		table.insert(uv0[slot1.activity_id].got_reward_id_list, slot6)
	end

	MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
	manager.notify:Invoke(MARDUK_SPECIAL_DATA_UPDATE, {})
end

function slot0.GetPoint(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.point
end

function slot0.GetCanGetRewardIndex(slot0)
	for slot5, slot6 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		slot7 = MardukSpecialData:GetPoint(slot6)
		slot8 = nil

		for slot12, slot13 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot6]) do
			slot15 = MardukSpecialData:HaveGotReward(slot6, slot13)

			if ActivityPointRewardCfg[slot13].need <= slot7 and not slot15 then
				return table.indexof(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list, slot6)
			end
		end
	end

	return 1
end

function slot0.GetGotRewardNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0) do
		slot1 = slot1 + #slot6.got_reward_id_list
	end

	return slot1
end

function slot0.HaveGotReward(slot0, slot1, slot2)
	if not uv0[slot1] then
		return false
	end

	if table.indexof(slot3.got_reward_id_list, slot2) then
		return true
	end

	return false
end

function slot0.OnGotReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		for slot12, slot13 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot7]) do
			if table.indexof(slot1, slot13) then
				table.insert(uv0[slot7].got_reward_id_list, slot13)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
			end
		end
	end

	manager.notify:Invoke(MARDUK_SPECIAL_REWARD_UPDATE, slot1)
end

return slot0
