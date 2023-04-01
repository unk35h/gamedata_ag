slot0 = singletonClass("HeroGiftData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitData(slot0, slot1)
	uv0[slot1.activity_id] = slot1.receive_state
end

function slot0.GetReceiveHeroGift(slot0, slot1)
	return uv0[slot1] or 1
end

function slot0.SetReceiveHeroGift(slot0, slot1)
	uv0[slot1] = 1
end

return slot0
