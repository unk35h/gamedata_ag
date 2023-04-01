slot0 = singletonClass("HeroInteractionGMData")
slot1 = {}

function slot0.GetParam(slot0)
	return uv0
end

function slot0.SetPatam(slot0, slot1, slot2, slot3)
	uv0 = {}

	table.insert(uv0, slot1)
	table.insert(uv0, slot2)
	table.insert(uv0, slot3)
end

function slot0.Updata(slot0, slot1, slot2, slot3)
	uv0:SetPatam(slot1, slot2, slot3)
end

return slot0
