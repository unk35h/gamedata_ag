slot0 = class("ChessForceBattleModel")

function slot0.Ctor(slot0)
	slot0.battleStart_ = false
	slot0.battleResult_ = 0
	slot0.battleID_ = nil
end

function slot0.SetUp(slot0, slot1)
	slot0.width_ = slot1
end

function slot0.BattleStart(slot0, slot1, slot2, slot3)
	slot0.battleStart_ = true
	slot0.battleResult_ = 0
	slot0.battleID_ = slot3

	slot0:SetBattleIndex(slot1, slot2)

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot0.originShadowRotationImmediately = slot4.shadowRotationImmediately
		slot4.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)
end

function slot0.SetBattleIndex(slot0, slot1, slot2)
	WarChessData:SetBattleIndex(slot2 * slot0.width_ + slot1 + 1)
end

function slot0.BattleResult(slot0, slot1)
	if not slot0.battleStart_ then
		return
	end

	slot0.battleResult_ = slot1 and 1 or 2
end

function slot0.IsForcingBattle(slot0)
	return slot0.battleStart_
end

function slot0.ForceEnterBossBattle(slot0, slot1)
	if slot1 then
		slot0.battleID_ = slot1
	else
		slot1 = slot0.battleID_
	end

	if not BattleChessStageCfg[slot1] then
		-- Nothing
	end

	slot2 = WarChessData:GetBossPos()
	slot3 = slot2[1]
	slot4 = slot2[2]
	slot5 = WarChessData:GetGridLua(slot3, slot4)

	slot0:BattleStart(slot3, slot4, slot1)
	gameContext:Go("/sectionSelectHero", {
		section = slot1,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS,
		activityID = WarChessData:GetCurrentActivity()
	})
end

function slot0.BattleFinish(slot0)
	if slot0.battleStart_ then
		ChessLuaBridge.SetCameraControlEnable(true)

		if manager.ui.mainCamera:GetComponent("CameraExtension") then
			slot1.shadowRotationImmediately = slot0.originShadowRotationImmediately
		end

		if slot0.battleResult_ == 0 then
			-- Nothing
		elseif slot0.battleResult_ == 1 then
			WarChessAction.CostShipHp(-30)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			slot0.battleStart_ = false
			slot0.battleResult_ = 0
		elseif slot0.battleResult_ == 2 then
			WarChessAction.CostShipHp(-50)

			if manager.ChessManager.current:ShipImmediatelyDie() then
				return
			end

			manager.ChessManager:DoNextEvent()

			slot0.battleStart_ = false
			slot0.battleResult_ = 0
		end
	end
end

function slot0.Dispose(slot0)
	slot0.battleStart_ = false
	slot0.battleResult_ = 0
end

return slot0
