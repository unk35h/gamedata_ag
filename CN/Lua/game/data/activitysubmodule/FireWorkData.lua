slot0 = singletonClass("FireWorkData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitFireData(slot0, slot1)
	uv0[slot1.activity_id] = {
		is_invited = slot1.is_invited == 1,
		is_rewarded = slot1.is_admitted == 1
	}
end

function slot0.SetRewarded(slot0, slot1, slot2)
	uv0[slot1] = uv0[slot1] or {}
	uv0[slot1].is_rewarded = slot2
end

function slot0.GetReward(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].is_rewarded
	else
		return true
	end
end

function slot0.SetInvited(slot0, slot1, slot2)
	uv0[slot1] = uv0[slot1] or {}
	uv0[slot1].is_invited = slot2
end

function slot0.GetInvited(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].is_invited
	else
		return false
	end
end

function slot0.GetFireData(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetRead(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

return slot0
