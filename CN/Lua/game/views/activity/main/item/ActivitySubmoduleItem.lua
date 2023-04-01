slot0 = class("ActivitySubmoduleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityId_ = slot2
	slot0.clickHandler_ = slot3

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.updateHandler_ = handler(slot0, slot0.UpdateActivity)
end

function slot0.OnEnter(slot0)
	slot0.activiteData_ = ActivityData:GetActivityData(slot0.activityId_)
	slot0.startTime_ = slot0.activiteData_.startTime
	slot0.stopTime_ = slot0.activiteData_.stopTime

	if slot0.stopTime_ < manager.time:GetServerTime() then
		if slot0.activityId_ == ActivityConst.SIKADI_GAME then
			SummerLittleGameAction.InitSkadiRedPoint()
		elseif slot0.activityId_ == ActivityConst.LEVIATHAN_GAME then
			SummerLittleGameAction.InitLeviathanRedPoint()
		end
	end

	slot0:BindRedPoint()
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPoint()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.updateHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.clickHandler_ ~= nil then
			uv0.clickHandler_()

			return
		end

		ActivityTools.JumpToSubmodulePage(uv0.activityId_)
	end)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, ActivityTools.GetRedPointKey(slot0.activityId_) .. slot0.activityId_)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, ActivityTools.GetRedPointKey(slot0.activityId_) .. slot0.activityId_)
end

function slot0.RefreshLock(slot0)
	slot1 = manager.time:GetServerTime() < slot0.startTime_
	slot2 = slot0.stopTime_ <= manager.time:GetServerTime()

	if slot0.controller_ then
		if slot2 then
			slot0.controller_:SetSelectedState("end")
		else
			slot0.controller_:SetSelectedState(tostring(slot1))
		end
	end

	if slot0.textTime_ then
		slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot0.startTime_, "!%m.%d"), manager.time:STimeDescS(slot0.stopTime_, "!%m.%d"))
	end
end

function slot0.UpdateActivity(slot0, slot1)
	if slot0.activityId_ == slot1 then
		slot0.activiteData_ = ActivityData:GetActivityData(slot0.activityId_)
		slot0.startTime_ = slot0.activiteData_.startTime
		slot0.stopTime_ = slot0.activiteData_.stopTime

		slot0:AddTimer()
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshLock()

	slot1 = manager.time:GetServerTime() < slot0.startTime_
	slot0.timer_ = Timer.New(function ()
		slot0 = manager.time:GetServerTime()

		if uv0 and uv1.startTime_ < slot0 then
			uv1:RefreshLock()

			uv0 = false
		elseif uv1.stopTime_ <= slot0 then
			uv1:RefreshLock()
			uv1:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
