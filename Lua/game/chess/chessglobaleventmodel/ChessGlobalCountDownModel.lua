slot0 = class("ChessGlobalAreaModel")

function slot0.Ctor(slot0, slot1)
	slot0.step = nil
	slot0.curEventID_ = nil
	slot0.handler_ = slot1
end

function slot0.SetUp(slot0, slot1)
	if slot0.curEventID_ and slot0.curEventID_ ~= slot1 then
		slot0.handler_:ClearGlobalEventByID(slot0.curEventID_)
	end

	slot0.curEventID_ = slot1
	slot2 = WarChessData:GetGlobalEventProgress(slot1) or WarchessGlobalCfg[slot1].params[1]

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[slot0.curEventID_].type, slot0.curEventID_, slot2)

	slot0.step = slot2
end

function slot0.IsConditionCheck(slot0, slot1, slot2)
	if slot2 == ChessConst.TIMING_WALK and slot0.step and slot0.step < 0 then
		return true
	end

	return false
end

function slot0.ExecutePhase(slot0, slot1)
	slot0.step = nil
	slot0.curEventID_ = nil
end

function slot0.UpdateProgress(slot0, slot1, slot2)
	if slot2 == ChessConst.TIMING_WALK then
		slot0.step = slot0.step - 1

		WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[slot1].type, slot1, slot0.step)
	end
end

function slot0.Dispose(slot0)
	slot0.step = nil
	slot0.curEventID_ = nil
end

return slot0
