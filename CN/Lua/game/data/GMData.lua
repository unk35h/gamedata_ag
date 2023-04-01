slot0 = singletonClass("GMData")

function slot0.Init(slot0)
	slot0.activityActiveList_ = {}
end

function slot0.EnabledActivity(slot0, slot1, slot2)
	if slot2 then
		table.insert(slot0.activityActiveList_, slot1)
	else
		table.removebyvalue(slot0.activityActiveList_, slot1)
	end
end

function slot0.ResetActivityList(slot0)
	slot0.activityActiveList_ = {}
end

function slot0.SetActivityList(slot0, slot1)
	slot0.activityActiveList_ = slot1
end

function slot0.GetActivityList(slot0)
	return slot0.activityActiveList_
end

return slot0
