slot0 = singletonClass("SkinExchangeData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			activityID = slot2
		}
	end

	uv0[slot2].state = slot1.received_state
end

function slot0.SetState(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].state = 1
	end
end

function slot0.GetState(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].state
	end

	return 1
end

return slot0
