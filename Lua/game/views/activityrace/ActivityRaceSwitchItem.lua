slot0 = class("ActivityRaceSwitchItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.scoreController_ = ControllerUtil.GetController(slot0.transform_, "score")

	SetActive(slot0.gameObject_, true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(uv0.activityID_)
		uv0:Go("/activityRaceSwitch", {
			activityID = uv0.activityID_,
			mainActivityID = uv0.mainActivityID_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.redPointStr_ = string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot1, slot2)

	manager.redPoint:bindUIandKey(slot0.transform_, slot0.redPointStr_)

	slot0.activityID_ = slot2
	slot0.mainActivityID_ = slot1
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.isLock_ = manager.time:GetServerTime() < slot0.startTime_

	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))

	slot0.mapNameText_.text = ActivityRaceCfg[slot0.activityID_].map_name

	slot0:RefreshScore()
	slot0:RefreshCompleted()
end

function slot0.RefreshScore(slot0)
	if ActivityRaceData:GetStateList()[slot0.activityID_] then
		slot0.score_ = slot1[slot0.activityID_].score
	else
		slot0.scoreController_:SetSelectedState("false")
	end

	if slot0.score_ and slot0.score_ ~= 0 then
		slot0.scoreController_:SetSelectedState("true")

		slot0.scoreText_.text = slot0.score_
	end
end

function slot0.RefreshCompleted(slot0)
end

function slot0.RefreshLock(slot0)
	if slot0.isLock_ == false then
		return
	end

	slot0.isLock_ = manager.time:GetServerTime() < slot0.startTime_

	if slot0.isLock_ == true then
		slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
	else
		slot0.lockController_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, slot0.redPointStr_)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
