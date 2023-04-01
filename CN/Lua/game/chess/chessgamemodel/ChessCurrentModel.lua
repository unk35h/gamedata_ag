slot0 = class("ChessCurrentModel")
slot1 = {
	[0] = {
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}

function slot0.Ctor(slot0)
	slot0.currentEvent_ = false
	slot0.isShow_ = false
	slot0.isDetector_ = false
	slot0.aboutToSlide_ = false
	slot0.bugFix_ = false
	slot0.aboutToDie_ = false
end

function slot0.SetUp(slot0, slot1)
	slot0.blockerManager_ = slot1
end

function slot0.ExtendSetup(slot0)
	if #WarChessData:GetDetectorPos() > 0 then
		slot0.isDetector_ = true

		ChessLuaBridge.LayDownChildBoatWithoutAnimation(slot1[1], slot1[2])
	end
end

function slot0.SlideByDirection(slot0, slot1)
	slot0.blockerManager_:ShowBlocker()
	ChessLuaBridge.SlideByDirection(slot1, 4)
	ChessLuaBridge.LookAtPlayer()

	slot0.currentEvent_ = true
end

function slot0.SlideByDirectionInCurrentState(slot0, slot1)
	ChessLuaBridge.SlideByDirection(slot1, 4)
end

function slot0.CurrentPatch(slot0)
	slot0.bugFix_ = true
end

function slot0.IsCurrentPatch(slot0)
	slot1 = nil
	slot0.bugFix_ = false

	return slot0.bugFix_
end

function slot0.CurrentEnd(slot0)
	slot0.currentEvent_ = false

	slot0.blockerManager_:HideBlocker()
end

function slot0.SetDetector(slot0, slot1)
	slot0.isDetector_ = slot1
end

function slot0.IsDetector(slot0)
	return slot0.isDetector_
end

function slot0.IsCurrentState(slot0)
	return slot0.currentEvent_
end

function slot0.LayDownOrUpShip(slot0, slot1, slot2)
	slot3 = nil

	if slot1 then
		slot4 = slot0.blockerManager_

		slot4:ShowBlocker()

		slot5 = WarChessData

		slot5:SetCharacterDirection(ChessLuaBridge.GetPlayerDirection())

		if not ChessLuaBridge.LayDownChildBoat(1, function ()
			uv0()
			uv1.blockerManager_:HideBlocker()
		end) then
			slot0.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RELIEVE")
		else
			slot0:SetDetector(true)
			WarChessAction.SwitchShipControl(2)

			slot5 = WarChessData:GetCurrentIndex()
			slot6 = uv0[math.fmod(slot4 + 3, 6)]

			WarChessData:SetDetectorPos(slot5.x + slot6[1], slot5.z + slot6[2])
		end
	else
		slot4 = slot0.blockerManager_

		slot4:ShowBlocker()

		if not ChessLuaBridge.PutUpChildBoat(function ()
			uv0()
			uv1.blockerManager_:HideBlocker()
		end) then
			slot0.blockerManager_:HideBlocker()
			ShowTips("ACTIVITY_WARCHESS_RECOVER")
		else
			slot0:SetDetector(false)
			WarChessAction.SwitchShipControl(1)
			WarChessData:SetDetectorPos()
		end
	end

	return slot3
end

function slot0.AboutToSlide(slot0, slot1)
	slot0.aboutToSlide_ = slot1
end

function slot0.IsAboutToSlide(slot0)
	slot0.aboutToSlide_ = false

	return slot0.aboutToSlide_ or false
end

function slot0.ShipImmediatelyDie(slot0)
	if WarChessData:GetShipHp() and slot1 <= 0 then
		slot2 = slot0.blockerManager_

		slot2:ShowBlocker()
		ChessLuaBridge.PlayRoleAnimation("dead", function ()
			slot0 = manager.notify

			slot0:CallUpdateFunc(SHIP_DIE)
			TimeTools.StartAfterSeconds(2, function ()
				uv0.blockerManager_:HideBlocker()
				OnExitChessScene(true)
			end, {})
		end)

		return true
	end
end

function slot0.ChessSuccess(slot0)
	slot1 = slot0.blockerManager_

	slot1:ShowBlocker()

	slot1 = manager.notify

	slot1:CallUpdateFunc(CHESS_SUCCESS)
	TimeTools.StartAfterSeconds(2, function ()
		uv0.blockerManager_:HideBlocker()
		OnExitChessScene(true)
	end, {})
end

function slot0.AboutToDie(slot0, slot1)
	if slot1 == 1 then
		slot0.aboutToDie_ = true
	elseif slot1 == 2 and slot0.aboutToDie_ then
		slot0:ShipImmediatelyDie()
	else
		slot0.aboutToDie_ = false
	end
end

function slot0.Dispose(slot0)
	slot0.currentEvent_ = false
	slot0.isShow_ = false
	slot0.isDetector_ = false
	slot0.aboutToSlide_ = false
	slot0.bugFix_ = false
	slot0.aboutToDie_ = false
end

return slot0
