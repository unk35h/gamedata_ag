slot0 = class("SoloChallengeSwitchItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")

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

		SoloChallengeData:SetSelectActivityID(uv0.mainActivityID_, uv0.activityID_)

		if uv0.callBack_ then
			uv0.callBack_()
		end
	end)
end

function slot0.SetActivityID(slot0, slot1, slot2)
	if slot0.activityID_ == nil then
		manager.redPoint:bindUIandKey(slot0.transformBtn_, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot2, slot1))
	elseif slot0.activityID_ ~= slot1 then
		manager.redPoint:unbindUIandKey(slot0.transformBtn_, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot2, slot0.activityID_))
		manager.redPoint:bindUIandKey(slot0.transformBtn_, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot2, slot1))
	end

	slot0.activityID_ = slot1
	slot0.mainActivityID_ = slot2
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.index_ = table.keyof(ActivityCfg[slot0.mainActivityID_].sub_activity_list, slot0.activityID_) or 1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.isLock_ = manager.time:GetServerTime() < slot0.startTime_

	if slot0.isLock_ == true then
		slot0.lockController_:SetSelectedState("true")

		slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
	else
		slot0.lockController_:SetSelectedState("false")
	end

	slot0:RefreshImage()
	slot0:RefreshTitle()
	slot0:RefreshCompleted()
end

function slot0.RefreshCompleted(slot0)
	if slot0.completedImageGo_ ~= nil then
		slot1 = #ActivitySoloChallengeCfg[slot0.activityID_].stage_id

		SetActive(slot0.completedImageGo_, SoloChallengeData:GetCompletedActivityList()[slot0.activityID_] and #slot2[slot0.activityID_] > 0)
	end
end

function slot0.RefreshImage(slot0)
	slot0.icon_.sprite = getSprite("Atlas/SummerUI", ActivitySoloChallengeCfg[slot0.activityID_].option_bg)
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = ActivitySoloChallengeCfg[slot0.activityID_].name
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.callBack_ = slot1
end

function slot0.OnSelect(slot0, slot1)
	if slot0.activityID_ == slot1 then
		slot0.selectController_:SetSelectedState("select")
	else
		slot0.selectController_:SetSelectedState("no")
	end
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

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transformBtn_, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0.mainActivityID_, slot0.activityID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:UnRegisterRedPoint()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.selectController_ = nil
	slot0.lockController_ = nil
end

return slot0
