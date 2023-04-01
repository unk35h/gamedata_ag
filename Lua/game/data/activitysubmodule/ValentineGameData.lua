slot0 = singletonClass("ValentineGameData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot2] = {
			id = slot2,
			isOpen = slot1.clear_state == 1
		}
	end

	uv0[slot2].isClear = slot1.clear_state ~= 0
	uv0[slot2].isReward = slot1.reward_state ~= 0
	uv0[slot2].point = slot1.point or 0
end

function slot0.GetData(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetOpen(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isOpen = true

		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. slot1, 0)
	end
end

function slot0.SetClear(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isClear = true

		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot1, 1)
	end
end

function slot0.SetReward(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].isReward = true

		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. slot1, 0)
	end
end

function slot0.SetPoint(slot0, slot1, slot2)
	uv0[slot1].point = slot2

	slot0:SetClear(slot1)
end

function slot0.SetLastLevel(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetLastLevel(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.SaveLastSelect(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

return slot0
