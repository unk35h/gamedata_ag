slot0 = class("ChessForceBattleModel")

function slot0.Ctor(slot0)
	slot0.battleProgress_ = false
	slot0.battleResult_ = 0
	slot0.battleTimes_ = 0
	slot0.battleList_ = {}
end

function slot0.SetUp(slot0, slot1)
	slot0.width_ = slot1
end

function slot0.SetBattleIndex(slot0)
	slot1 = manager.ChessManager:GetExecutingChess()

	WarChessData:SetBattleIndex(slot1.z * slot0.width_ + slot1.x + 1)
end

function slot0.BattleResult(slot0, slot1)
	if not slot0.battleProgress_ then
		return
	end

	slot0.battleResult_ = slot1 and 1 or 2
end

function slot0.IsMutiBattle(slot0)
	return slot0.battleProgress_ and true or false
end

function slot0.EnterMutiBattle(slot0, slot1, slot2)
	if not slot0.battleProgress_ then
		slot0.battleTimes_ = slot1
		slot0.battleList_ = slot2
		slot0.battleProgress_ = 0
		slot3 = manager.ChessManager:GetExecutingChess()

		WarChessAction.SetMutiTeam(slot3.x, slot3.z)
	end

	if not BattleChessStageCfg[slot0.battleList_[slot0.battleProgress_ + 1]] then
		-- Nothing
	end

	slot0:BattleStart(slot3)
end

function slot0.BattleStart(slot0, slot1)
	slot0.battleProgress_ = slot0.battleProgress_ or 0
	slot0.battleResult_ = 0
	slot0.battleID_ = slot1

	slot0:SetBattleIndex()

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot0.originShadowRotationImmediately = slot2.shadowRotationImmediately
		slot2.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function slot0.ExitMutiBattle(slot0)
	slot0.battleProgress_ = false
	slot0.battleResult_ = 0

	manager.ChessManager:EventsEnd()
end

function slot0.Dispose(slot0)
	slot0.battleProgress_ = false
	slot0.battleResult_ = 0
	slot0.battleTimes_ = 0
	slot0.battleList_ = {}
end

return slot0
