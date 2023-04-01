slot0 = class("AtlasMgr")

function slot0.Ctor(slot0)
	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	slot0.spritePool_ = {}
end

function slot0.GetSprite(slot0, slot1, slot2)
	if not slot0.spritePool_[slot1 .. slot2] then
		slot0.spritePool_[slot3] = getSprite(slot1, slot2)
	end

	return slot0.spritePool_[slot3]
end

function slot0.UnloadSprite(slot0, slot1)
	for slot5, slot6 in pairs(slot0.spritePool_) do
		if string.find(slot5, slot1) then
			Object.Destroy(slot6)

			slot0.spritePool_[slot5] = nil
		end
	end
end

function slot0.UnloadAllSprite(slot0)
	for slot4, slot5 in pairs(slot0.spritePool_) do
		Object.Destroy(slot5)

		slot0.spritePool_[slot4] = nil
	end

	slot0.spritePool_ = {}
end

return slot0
