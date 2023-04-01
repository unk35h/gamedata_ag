slot0 = singletonClass("RedPointData")
slot1, slot2 = nil

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitRedPointS(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:SetRedPointOpen(slot6, true)
	end
end

function slot0.InitClientRedPoint(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:SetRedPointOpen(slot6, true)
	end
end

function slot0.SetRedPointOpen(slot0, slot1, slot2)
	uv0[tonumber(slot1)] = slot2
end

function slot0.GetRedPointOpen(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetIsRedPointOpen(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetJsonCacheRedPoint(slot0, slot1)
	return getData("RedPoint", slot1) or 1
end

function slot0.SetJsonCacheRedPoint(slot0, slot1)
	saveData("RedPoint", slot1, 0)
end

slot0.HasNotified = 0
slot0.NotYetNotified = 1

function slot0.GetSessionCacheRedPoint(slot0, slot1)
	return nullable(uv0, slot1) or 1
end

function slot0.SetSessionCacheRedPoint(slot0, slot1)
	uv0[slot1] = 0
end

function slot0.UpdateRedPoint(slot0, slot1)
	if slot1 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
		slot2 = RedPointConst.WARCHESS_CHINESE .. "_" .. ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE

		if ActivityData:GetActivityIsOpen(ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE) then
			manager.redPoint:setTip(slot2, slot0:GetJsonCacheRedPoint(slot2))
		else
			manager.redPoint:setTip(slot2, 0)
		end
	end
end

return slot0
