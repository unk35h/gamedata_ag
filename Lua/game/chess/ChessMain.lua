slot0 = singletonClass("ChessMain")

function slot0.Ctor(slot0)
	slot0.eventData_ = {}
	slot0.finalChess_ = {}
	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil
	slot0.chessEntities_ = {}
	slot0.cachePath_ = {}
	slot0.battleStart_ = false
	slot0.battleResult_ = false
	slot0.mutiTimes_ = nil
	slot0.selectGrid_ = nil
	slot0.map_ = nil
	slot0.bulletDirection_ = nil
	slot0.bulletEvent_ = 0
	slot0.eventQueueManager_ = ChessEventQueue.New()
	slot0.current = ChessCurrentModel.New(slot0.blockerManager_)
	slot0.forceBattle = ChessForceBattleModel.New()
	slot0.mutiBattle = ChessMutiBattleModel.New()
	slot0.characterPos_ = nil
	slot0.curStoneGirdData_ = nil
	slot0.movedStoneGridData_ = nil
end

function slot0.SetUp(slot0, slot1)
	slot0.blockerManager_ = ChessBlockerManager.New(manager.ui.canvas)
	slot0.globalEventManager_ = ChessGlobalEventManager.New(slot0)

	slot0:LoadMap(slot1)
	slot0.current:SetUp(slot0.blockerManager_)
	slot0.forceBattle:SetUp(slot0.map_.width)
	slot0.mutiBattle:SetUp(slot0.map_.width)

	if WarChessData:GetButterFlyPos() then
		ChessLuaBridge.InitGuider(WarChessTools.GetGuiderAssetPath(slot1), slot2[1], slot2[2])
	end

	if not table.indexof(WarchessLevelCfg[slot1].extra_gameplay, 2) then
		slot3 = WarChessData:GetCurrentIndex()
		slot0.characterPos_ = {
			slot3.x,
			slot3.z
		}
	end
end

function slot0.IsExecuting(slot0)
	return slot0.IsExecuting_
end

function slot0.ExecutingChess(slot0, slot1, slot2, slot3)
	slot4 = slot2.typeID
	slot5 = slot2.status

	if slot1 == ChessConst.TIMING_WALK and not ChessTools.IsWalkEvent(slot4, slot5) then
		slot0.eventQueueManager_:InsertNewEventQueue(ChessTools.ParseEventPollCfg({
			{
				10000
			}
		}), slot1, slot2)
	elseif slot1 == ChessConst.TIMING_CURRENT and not ChessTools.IsWalkEvent(slot4, slot5) then
		slot0.eventQueueManager_:InsertNewEventQueue(ChessTools.ParseEventPollCfg({
			{
				10000
			}
		}), slot1, slot2)
	else
		slot0:CreateEventQueue(slot2, slot3, slot1)
	end

	if slot0.eventQueueManager_:CurEventTiming() then
		return
	end

	if slot0.eventQueueManager_:PromoteToNextEvent() then
		slot0:DoNextEvent()
	else
		slot0:EventsEnd()
	end
end

function slot0.LoadMap(slot0, slot1)
	slot0.ChapterID = slot1

	if slot0.map_ then
		return
	end

	WarChessData:SetStartTime(manager.time:GetServerTime())

	slot0.map_ = ChessTools.LoadMap(slot1)

	if not slot0.map_ then
		-- Nothing
	end

	WarChessData:SetExtendMap(slot0.map_.extendInfo)

	slot6 = {}

	WarChessData:SetJsonMap(slot6)

	for slot6, slot7 in pairs(slot0.map_.mapInfo) do
		slot2[ChessTools.TwoDToOneD(slot7.x, slot7.z)] = slot7
	end

	for slot7, slot8 in pairs(WarChessData:GetCurrentWarChessMapData().mapChangeInfo) do
		slot0:CreateChess(slot2[ChessTools.TwoDToOneD(slot8.pos.x, slot8.pos.z)], slot8.status)
	end

	for slot7, slot8 in pairs(slot0.map_.mapInfo) do
		slot0:CreateChess(slot8, slot8.status)
	end
end

function slot0.CachePath(slot0, slot1)
	slot0.cachePath_ = slot1
end

function slot0.InsertGlobalEventList(slot0, slot1)
	slot0.globalEventManager_:InsertGlobalEventList(slot1)
end

function slot0.ClearGlobalEventByType(slot0, slot1)
	slot0.globalEventManager_:ClearGlobalEventByType(slot1)
end

function slot0.GetExecutingChess(slot0)
	return slot0.eventQueueManager_:GetExecutingChess()
end

function slot0.CreateEventQueue(slot0, slot1, slot2, slot3)
	if not WarchessEventPoolCfg[slot1.paramList[0]] then
		-- Nothing
	end

	slot0.eventQueueManager_:InsertNewEventQueue(slot2, slot3, slot1)
end

function slot0.InsertEventQueue(slot0, slot1, slot2)
	if slot2 == "GLOBAL" then
		slot0.eventQueueManager_:InsertNewEventQueue(slot1, "GLOBAL")
	else
		slot0.eventQueueManager_:InsertCurEventQueue(slot1)
	end
end

function slot0.DoNextEvent(slot0)
	if slot0.eventQueueManager_:LastEventID() then
		WarChessData:ExecuteEventOneTime(slot1)
	end

	if slot0.eventQueueManager_:IsEventEnd() then
		slot0:EventsEnd()

		return
	end

	slot2, slot3 = slot0.eventQueueManager_:GetCurFunc()

	slot0.eventQueueManager_:PromoteCurEventProgress()

	return slot2(unpack(slot3))
end

function slot0.EventsEnd(slot0)
	if slot0.eventQueueManager_:CurEventTiming() == ChessConst.TIMING_INTERACT then
		slot0.IsExecuting_ = false
		slot0.ExecutingChess_ = nil
	end

	if slot1 ~= nil then
		slot0.globalEventManager_:ExecuteGlobalEvent(slot1)
	end

	if slot0.eventQueueManager_:PromoteToNextEvent() then
		slot0:DoNextEvent()
	else
		slot0.eventQueueManager_:Clear()

		if WarChessData:GetStoneIsMoving() then
			ChessLuaBridge.StoneContinueMove()
		end
	end
end

function slot0.CreateChess(slot0, slot1, slot2)
	slot3 = ChessTools.ParseParameter(slot1, true)

	if slot0.chessEntities_[ChessTools.TwoDToOneD(slot1.x, slot1.z)] then
		return
	end

	for slot8, slot9 in pairs(slot3) do
		if ChessTools.IsSavingEvent(slot9.eventID) then
			slot0.chessEntities_[slot4] = {
				x = slot1.x,
				z = slot1.z
			}

			return
		end
	end
end

function slot0.ExecutingCreatedChess(slot0, slot1)
	for slot5, slot6 in pairs(slot0.chessEntities_) do
		for slot12, slot13 in pairs(ChessTools.ParseParameter(ChessLuaBridge.GetGridData(slot6.x, slot6.z))) do
			if ChessEventConfig[slot13.eventID][slot1] then
				slot14(slot5, slot6, unpack(slot13.params))
			end
		end
	end
end

function slot0.SetPosition(slot0, slot1, slot2)
	if slot0.characterPos_ and slot0.characterPos_[1] == slot1 and slot0.characterPos_[2] == slot2 then
		return false
	end

	slot3 = WarChessData

	slot3:SetCurrentIndex(slot1, slot2)

	slot0.characterPos_ = {
		slot1,
		slot2
	}

	return true
end

function slot0.SetInteractChess(slot0, slot1)
	slot0.IsExecuting_ = true
	slot0.ExecutingChess_ = slot1
end

function slot0.ExecuteMove(slot0)
	WarChessAction.RoleMoveByPath(slot0.cachePath_, function (slot0)
		if not isSuccess(slot0) then
			ShowTips(slot0)
			ChessLuaBridge.ClearCachePath()
		else
			manager.notify:CallUpdateFunc(CAMERA_MOVE, false)
			ChessLuaBridge.MoveToCachePos()
			uv0.blockerManager_:ShowBlocker()
		end
	end)
end

function slot0.OnMoveEnd(slot0)
	slot0.blockerManager_:HideBlocker()
	slot0:SetGridSelectOutline(nil, , false)
end

function slot0.StopMove(slot0)
	slot0.stopMove_ = true
end

function slot0.IsStopMove(slot0)
	if slot0.stopMove_ then
		slot0.stopMove_ = false

		return true
	end

	return false
end

function slot0.ExecuteChessTiming(slot0, slot1, slot2)
	slot3 = slot2.gridData
	slot4 = false
	slot5 = slot2.isError

	if slot1 == ChessConst.TIMING_START then
		slot0.globalEventManager_:ExecuteGlobalEvent(ChessConst.TIMING_START)

		if slot0.eventQueueManager_:PromoteToNextEvent() then
			slot0:DoNextEvent()
		else
			slot0.eventQueueManager_:Clear()
		end
	elseif slot1 == ChessConst.TIMING_CLICK then
		slot0.stopMove_ = false

		if ChessTools.IsInteract(slot3.typeID, slot3.status) then
			if slot3.paramList.Length == 0 then
				-- Nothing
			end

			if ChessTools.IsShowMessage(slot3.paramList[0], slot3.status) == "" then
				if slot5 then
					ChessTools.CantReach(slot3.x, slot3.z)
				else
					ChessEventConfig[2][1](slot3)
				end
			elseif slot6[1] == 1 then
				ChessEventConfig[3][1](slot3, slot6[2], slot5)
			elseif slot6[1] == 2 then
				ChessEventConfig[4][1](slot3, slot6[2], slot5)
			end
		elseif slot5 then
			ChessTools.CantReach(slot3.x, slot3.z)
		else
			ChessEventConfig[1][1]()
		end
	elseif slot1 == ChessConst.TIMING_WALK then
		slot0:ExecutingChess(slot1, slot3, ChessTools.ParseParameter(slot3))

		if slot0:IsStopMove() then
			slot0.IsExecuting_ = false
			slot0.ExecutingChess_ = nil
		end

		slot4 = slot7
	elseif slot1 == ChessConst.TIMING_INTERACT then
		slot3 = slot0.ExecutingChess_
		slot6 = ChessTools.ParseParameter(slot3)

		WarChessAction.TouchGrid({
			x = slot3.x,
			z = slot3.z
		}, nil, 1, function ()
			uv0:ExecutingChess(uv1, uv2, uv3)
		end)
	elseif slot1 == ChessConst.TIMING_HIT then
		slot0:ExecutingChess(slot1, slot3, ChessTools.ParseParameter(slot3, false, true))
	elseif slot1 == ChessConst.TIMING_CURRENT then
		if table.length(ChessTools.ParseParameter(slot3, false, true)) == 0 and slot3.typeID ~= 10101 then
			Debug.LogError(string.format("洋流状态中... 这个格子没参数:(%d,%d)", slot3.x, slot3.z))
		end

		slot0:ExecutingChess(slot1, slot3, slot6)

		slot4 = slot0:IsStopMove()
	elseif slot1 == ChessConst.TIMING_CURRENT_HIT then
		slot6 = ChessTools.ParseParameter(slot3, false, true)

		WarChessAction.TouchGrid({
			x = slot3.x,
			z = slot3.z
		}, nil, 2, function ()
			uv0:ExecutingChess(uv1, uv2, uv3)
		end)
	elseif slot1 == ChessConst.TIMING_STONE_MOVE then
		slot0:ExecutingChess(slot1, slot3, ChessTools.ParseParameter(slot3, false, true))
	end

	slot0.LastState_ = slot1

	return slot4
end

function slot0.Dispose(slot0)
	manager.windowBar:ClearWhereTag()

	slot0.eventData_ = {}
	slot0.finalChess_ = {}
	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil
	slot0.chessEntities_ = {}
	slot0.map_ = nil
	slot0.battleStart_ = false
	slot0.battleResult_ = false
	slot0.mutiTimes_ = nil

	slot0.blockerManager_:Dispose()
	slot0.globalEventManager_:Dispose()
	slot0.eventQueueManager_:Clear()
	slot0.current:Dispose()
	slot0.forceBattle:Dispose()
	slot0.mutiBattle:Dispose()

	slot0.selectGrid_ = nil
	slot0.bulletDirection_ = nil
	slot0.bulletEvent_ = 0
	slot0.characterPos_ = nil

	if slot0.bulletTimer_ then
		slot0.bulletTimer_:Stop()

		slot0.bulletTimer_ = nil
	end
end

function slot0.BattleStart(slot0, slot1)
	slot0.battleStart_ = true
	slot0.battleResult_ = nil
	slot0.mutiTimes_ = slot1

	slot0:SetBattleIndex()

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot0.originShadowRotationImmediately = slot2.shadowRotationImmediately
		slot2.shadowRotationImmediately = true
	end

	ChessLuaBridge.SetCameraControlEnable(false)

	if not manager.ChessManager.current:IsDetector() then
		WarChessData:SetCharacterDirection(ChessLuaBridge.GetPlayerDirection())
	end
end

function slot0.SetBattleIndex(slot0)
	slot1 = slot0:GetExecutingChess()

	WarChessData:SetBattleIndex(slot1.z * slot0.map_.width + slot1.x + 1)
end

function slot0.BattleSuccess(slot0)
	slot0.battleResult_ = true

	if slot0.mutiTimes_ then
		slot0.mutiTimes_ = slot0.mutiTimes_ - 1
	end
end

function slot0.BattleFinish(slot0)
	if slot0.battleStart_ then
		if slot0.mutiTimes_ then
			if slot0.battleResult_ and slot0.mutiTimes_ == 0 then
				slot0:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
				slot0:DoNextEvent()
			else
				slot0:EventsEnd()
			end
		elseif slot0.battleResult_ then
			slot0:ExecutingCreatedChess(ChessConst.EVENT.AFTER_BATTLE)
			slot0:DoNextEvent()
		else
			slot0:EventsEnd()
		end
	end

	if not slot0.battleStart_ then
		return
	end

	slot0.battleStart_ = false
	slot0.battleResult_ = nil
	slot0.mutiTimes_ = nil

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot1.shadowRotationImmediately = slot0.originShadowRotationImmediately
	end

	ChessLuaBridge.SetCameraControlEnable(true)
end

function slot0.LookAtPlayerWithCurPos(slot0, slot1, slot2, slot3)
	slot4 = WarChessData:GetCurrentIndex()

	if math.abs(slot4.x - slot1) + math.abs(slot4.z - slot2) > 2 then
		ChessLuaBridge.LookAtPlayer(function ()
			if uv0 then
				uv0()
			end
		end)
	elseif slot3 then
		slot3()
	end
end

function slot0.ChangeGridStatus(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		ChessLuaBridge.ChangeGridStatus(uv0, uv1, uv2, function ()
			slot0 = uv0

			slot0:LookAtPlayerWithCurPos(uv1, uv2, function ()
				uv0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridStatusLua(uv1, uv2, uv3)

				if uv4 then
					uv4()
				end
			end)
		end)
	end, true)
end

function slot0.PlayGridAnimation(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		ChessLuaBridge.PlayGridAnimation(uv0, uv1, uv2, function ()
			slot0 = uv0

			slot0:LookAtPlayerWithCurPos(uv1, uv2, function ()
				uv0.blockerManager_:HideBlocker()
				uv1()
			end)
		end)
	end, true)
end

function slot0.ChangeGridDirection(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0.blockerManager_

	slot6:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		ChessLuaBridge.RotateGrid(uv0, uv1, uv2 * 60, uv3, function ()
			slot0 = uv0

			slot0:LookAtPlayerWithCurPos(uv1, uv2, function ()
				uv0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridDirection(uv1, uv2, uv3)

				if uv4 then
					uv4()
				end
			end)
		end)
	end, true)
end

function slot0.ChangeGridByList(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot3, slot9.x)
		table.insert(slot4, slot9.z)
	end

	slot5 = #slot1

	function slot6()
		uv0 = uv0 - 1

		if uv0 <= 0 then
			ChessLuaBridge.LookAtPlayer(function ()
				uv0.blockerManager_:HideBlocker()

				if uv1 then
					uv1()
				end
			end)
		end
	end

	slot7 = slot0.blockerManager_

	slot7:ShowBlocker()
	ChessLuaBridge.LookAtTarget(slot3, slot4, function ()
		for slot3 = 1, #uv0 do
			slot5 = uv0[slot3]

			if uv0[slot3].style == 1 then
				ChessLuaBridge.ChangeGridStatus(slot5.x, slot5.z, slot5.param, uv1)
			elseif slot4 == 2 then
				ChessLuaBridge.ChangeGridByIndex(slot5.x, slot5.z, slot5.param, uv1)
			elseif slot4 == 3 then
				ChessLuaBridge.RotateGrid(slot5.x, slot5.z, slot5.param[1] * 60, slot5.param[2], uv1)
			end
		end
	end, true)
end

function slot0.ChangeGridByIndex(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		ChessLuaBridge.ChangeGridByIndex(uv0, uv1, uv2, function ()
			slot0 = uv0

			slot0:LookAtPlayerWithCurPos(uv1, uv2, function ()
				uv0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(uv1, uv2, uv3)

				if uv4 then
					uv4()
				end
			end)
		end)
	end, true)
end

function slot0.ChangeGridByIndexWithOutLook(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.ChangeGridByIndex(slot1, slot2, slot3, function ()
		uv0.blockerManager_:HideBlocker()
		WarChessData:ChangeGridLua(uv1, uv2, uv3)

		if uv4 then
			uv4()
		end
	end)
end

function slot0.ChangeGridByGridData(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		ChessLuaBridge.ChangeGrid(uv0, uv1, uv2, function ()
			slot0 = uv0

			slot0:LookAtPlayerWithCurPos(uv1, uv2, function ()
				uv0.blockerManager_:HideBlocker()
				WarChessData:ChangeGridLua(uv1, uv2, 0)

				if uv3 then
					uv3()
				end
			end)
		end)
	end, true)
end

function slot0.MoveToTarget(slot0, slot1, slot2, slot3)
	slot4 = slot0.blockerManager_

	slot4:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		uv0.blockerManager_:HideBlocker()

		if uv1 then
			uv1()
		end
	end)
end

function slot0.LookAtPlayer(slot0, slot1)
	slot2 = slot0.blockerManager_

	slot2:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function ()
		uv0.blockerManager_:HideBlocker()

		if uv1 then
			uv1()
		end
	end)
end

function slot0.LookForSeconds(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.blockerManager_

	slot5:ShowBlocker()
	ChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		TimeTools.StartAfterSeconds(uv0, function ()
			ChessLuaBridge.LookAtPlayer(function ()
				uv0.blockerManager_:HideBlocker()

				if uv1 then
					uv1()
				end
			end)
		end, {})
	end)
end

function slot0.SetGridSelectOutline(slot0, slot1, slot2, slot3)
	if slot3 then
		if slot0.selectGrid_ then
			ChessLuaBridge.SetGridSelectOutline(slot0.selectGrid_.x, slot0.selectGrid_.z, false)
		end

		ChessLuaBridge.SetGridSelectOutline(slot1, slot2, true)

		slot0.selectGrid_ = {
			x = slot1,
			z = slot2
		}
	elseif slot0.selectGrid_ then
		ChessLuaBridge.SetGridSelectOutline(slot0.selectGrid_.x, slot0.selectGrid_.z, false)

		slot0.selectGrid_ = nil
	end
end

function slot0.ShowBlocker(slot0)
	slot0.blockerManager_:ShowBlocker()
end

function slot0.HideBlocker(slot0)
	slot0.blockerManager_:HideBlocker()
end

slot1 = 0

function slot0.bulletBarrierFunction(slot0)
	uv0 = uv0 + 1

	if uv0 == 2 then
		slot0.blockerManager_:HideBlocker()

		uv0 = 0
	elseif uv0 > 2 then
		-- Nothing
	end
end

function slot0.FireBullet(slot0)
	slot1 = manager.notify

	slot1:CallUpdateFunc(CAMERA_MOVE, false)

	slot1 = slot0.blockerManager_

	slot1:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function ()
		WarChessAction.FireByPlayer(function ()
			ChessLuaBridge.FireByPlayer()

			uv0.bulletEvent_ = uv0.bulletEvent_ + 1
			uv0.bulletTimer_ = TimeTools.StartAfterSeconds(1.67, function ()
				uv0:bulletBarrierFunction()
			end, {})
		end)
	end)
end

function slot0.BulletContinue(slot0)
	slot0.bulletEvent_ = slot0.bulletEvent_ + 1
end

function slot0.OnBulletEnd(slot0)
	slot0.bulletEvent_ = slot0.bulletEvent_ == 0 and 0 or slot0.bulletEvent_ - 1

	if not slot0.bulletEvent_ or slot0.bulletEvent_ == 0 then
		slot0:bulletBarrierFunction()
	end
end

function slot0.SetBulletDirection(slot0, slot1)
	slot0.bulletDirection_ = slot1
end

function slot0.GetBulletDirection(slot0)
	return slot0.bulletDirection_
end

function slot0.SetCountDown(slot0, slot1)
	if slot1 then
		ChessLuaBridge.SetCountText(slot1)
	else
		ChessLuaBridge.SetCountText(0, false)
	end
end

function slot0.StoneStartToMove(slot0, slot1, slot2)
	slot3 = slot0.blockerManager_

	slot3:ShowBlocker()
	ChessLuaBridge.LookAtPlayer(function ()
		ChessLuaBridge.StoneMove(uv0, uv1)
	end)
end

return slot0
