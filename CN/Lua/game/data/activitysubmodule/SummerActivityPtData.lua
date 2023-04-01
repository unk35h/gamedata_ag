slot0 = singletonClass("SummerActivityPtData")
slot1 = {}

function slot0.Reset(slot0)
	uv0 = {}
end

function slot0.InitWithServer(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not uv0[slot5] then
			uv0[slot6.id] = {}
		end

		uv0[slot6.id].id = slot6.id
		uv0[slot6.id].clear_time = slot6.clear_time
	end

	manager.notify:Invoke(SUMMER_ACTIVITY_PT_UPDATE, {})
end

function slot0.GetLevelChallengeCount(slot0, slot1)
	if not uv0 or not uv0[slot1] then
		return 0
	end

	return uv0[slot1].clear_time
end

return slot0
