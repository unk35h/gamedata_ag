require("game.data.ActivityDataTemplate")

slot0 = singletonClass("ActivityData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	slot0.activityTimeList_ = {}
end

function slot0.InitActivityData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.activity_list) do
		if uv0[ActivityTemplate.New(slot6).id] then
			Debug.LogError("Error Duplicate activity ID")
		end

		uv0[slot7.id] = slot7
		uv1[slot7.id] = {
			startTime = slot7.startTime,
			stopTime = slot7.stopTime
		}

		manager.notify:Invoke(ACTIVITY_UPDATE, slot7.id)
	end
end

function slot0.UpdateActivityData(slot0, slot1)
	slot2 = ActivityTemplate.New(slot1)
	uv0[slot2.id] = slot2

	manager.notify:Invoke(ACTIVITY_UPDATE, slot2.id)

	return slot2
end

function slot0.GetAllActivityData(slot0)
	return uv0
end

function slot0.GetActivityData(slot0, slot1)
	return uv0[slot1] or ActivityTemplate.New({
		stop_time = 1,
		start_time = 0,
		activity_id = slot1
	})
end

function slot0.GetActivityIsOpen(slot0, slot1)
	if uv0[slot1] == nil then
		return false
	end

	return slot2:IsActivitying()
end

function slot0.GetRankVersion(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return uv0[slot1]
end

function slot0.SetRankVersion(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.RefreshActivityTime(slot0, slot1)
	slot0.activityTimeList_[slot1.activity_id] = slot1.refresh_time
end

function slot0.GetActivityRefreshTime(slot0, slot1)
	return slot0.activityTimeList_[slot1] or 0
end

function slot0.GetActivityTime(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].startTime, uv0[slot1].stopTime
	end

	if uv1[slot1] then
		return uv1[slot1].startTime, uv1[slot1].stopTime
	end

	return 0, 0
end

return slot0
