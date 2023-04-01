slot0 = class("ChessGlobalAreaModel")

function slot0.Ctor(slot0)
	slot0.areaMemory_ = {}
end

function slot0.SetUp(slot0, slot1)
	slot0.areaMemory_[slot1] = ChessTools.PhraseArea(WarchessGlobalCfg[slot1].params)
end

function slot0.IsConditionCheck(slot0, slot1)
	slot2 = WarChessData:GetCurrentIndex()

	if not slot0.areaMemory_[slot1] then
		return false
	end

	return slot0.areaMemory_[slot1][ChessTools.TwoDToOneD(slot2.x, slot2.z)]
end

function slot0.ExecutePhase(slot0, slot1)
	slot0.areaMemory_[slot1] = nil

	manager.ChessManager:StopMove()
end

function slot0.UpdateProgress(slot0)
end

function slot0.Dispose(slot0)
	slot0.areaMemory_ = {}
end

return slot0
