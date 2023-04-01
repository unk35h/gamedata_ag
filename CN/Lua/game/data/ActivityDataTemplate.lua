ActivityTemplate = class("ActivityTemplate")

function ActivityTemplate.Ctor(slot0, slot1)
	slot0.id = slot1.activity_id
	slot0.startTime = slot1.start_time
	slot0.stopTime = slot1.stop_time
	slot0.state = slot1.state or 0
	slot0.theme = slot1.theme or 0
	slot0.template = slot1.template or 0
	slot0.subActivityIdList = {}

	if slot1.sub_activity_id_list then
		for slot5, slot6 in ipairs(slot1.sub_activity_id_list) do
			table.insert(slot0.subActivityIdList, slot6)
		end
	end
end

function ActivityTemplate.IsActivitying(slot0)
	slot1 = manager.time:GetServerTime()

	if slot0.stopTime == 0 then
		return true
	end

	if slot1 <= slot0.stopTime then
		if slot0.state ~= 1 then
			return false
		end

		return true
	end

	return false
end

function ActivityTemplate.IsOverdue(slot0)
	slot1 = manager.time:GetServerTime()

	if slot0.stopTime == 0 then
		return false
	end

	return slot0.stopTime < slot1
end

function ActivityTemplate.GetRemainTime(slot0)
	return slot0.stopTime - manager.time:GetServerTime()
end

function ActivityTemplate.GetTimeBeforeStart(slot0)
	return slot0.startTime - manager.time:GetServerTime()
end

function ActivityTemplate.GetStateBool(slot0)
	return slot0.state == 1
end
