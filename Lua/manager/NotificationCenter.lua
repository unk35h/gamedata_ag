slot0 = singletonClass("NotificationCenter")
slot0.AllListener = {}

function slot0.RegistListener(slot0, slot1, slot2)
	if not uv0.AllListener[slot1] then
		uv0.AllListener[slot1] = {}
	end

	table.insert(uv0.AllListener[slot1], slot2)
end

function slot0.RemoveListener(slot0, slot1, slot2)
	if uv0.AllListener[slot1] and table.keyof(uv0.AllListener[slot1], slot2) then
		table.remove(uv0.AllListener[slot1], slot3)
	end
end

function slot0.Invoke(slot0, slot1, ...)
	if uv0.AllListener[slot1] then
		for slot5, slot6 in pairs(uv0.AllListener[slot1]) do
			slot6(...)
		end
	end
end

function slot0.CallUpdateFunc(slot0, slot1, ...)
	for slot6, slot7 in pairs(gameContext:GetAllOpenPage()) do
		if slot7[slot1] then
			slot7:__slot1_None__(...)
		end
	end
end

return slot0
