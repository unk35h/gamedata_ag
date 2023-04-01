slot0 = class("ChessGlobalCheckModel")

function slot0.Ctor(slot0)
	slot0.curEventIDList_ = {}
	slot0.curConditionList_ = {}
end

function slot0.SetUp(slot0, slot1)
	if slot0.curEventIDList_[slot1] then
		return
	end

	slot0.curEventIDList_[slot1] = WarchessGlobalCfg[slot1].params
	slot0.curConditionList_[slot1] = false
end

function slot0.IsConditionCheck(slot0, slot1, slot2)
	if slot0.curConditionList_[slot1] then
		slot0.curConditionList_[slot1] = nil

		return true
	end

	return false
end

function slot0.ExecutePhase(slot0, slot1)
end

function slot0.UpdateProgress(slot0, slot1, slot2)
	slot3 = false

	if manager.ChessManager:GetExecutingChess() then
		for slot8, slot9 in pairs(slot0.curEventIDList_[slot1]) do
			if slot4.x == slot9[1] and slot4.z == slot9[2] then
				slot3 = true

				break
			end
		end

		if slot3 then
			for slot8, slot9 in pairs(slot0.curEventIDList_[slot1]) do
				if not WarChessData:GetGridIsChanged(slot9[1], slot9[2]) then
					return
				end
			end

			slot0.curEventIDList_[slot1] = nil
			slot0.curConditionList_[slot1] = true

			return
		end
	end
end

function slot0.Dispose(slot0)
	slot0.curEventIDList_ = {}
	slot0.curConditionList_ = {}
end

return slot0
