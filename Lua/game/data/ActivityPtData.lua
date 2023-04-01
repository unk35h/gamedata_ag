slot0 = singletonClass("ActivityPtData")
slot1 = {}
slot2 = {}

function slot0.Ctor(slot0, ...)
	uv0 = {}

	for slot4, slot5 in ipairs(ActivityPtCfg) do
		uv0[slot5.id] = {
			num = 0,
			id = slot5.id
		}
	end
end

function slot0.ActivityPtModify(slot0, slot1, slot2)
	uv0[slot1].num = uv0[slot1].num + slot2

	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
end

function slot0.TaskDailyGetRewardInit(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.activity_pt_id].num = slot6.active_point
		uv1[slot6.activity_pt_id] = {}

		for slot10, slot11 in ipairs(slot6.get_id_list) do
			uv1[slot6.activity_pt_id][slot11] = true
		end
	end

	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
end

function slot0.TaskDailySubmit(slot0, slot1)
	uv0[slot1.activityID][slot1.activityPt] = true

	manager.notify:Invoke(ACTIVITY_PT_UPDATE)
end

function slot0.GetCurrentActivityPt(slot0, slot1)
	return uv0[slot1] and uv0[slot1].num or 0
end

function slot0.GetGiftPt(slot0, slot1, slot2)
	return ActivityPtCfg[slot1] and slot3.target[slot2] or 0
end

function slot0.GetTotalPt(slot0, slot1)
	return ActivityPtCfg[slot1] and slot2.target[#slot2.target] or 0
end

function slot0.GetDailyGetRewardList(slot0)
	return uv0 or {}
end

return slot0
