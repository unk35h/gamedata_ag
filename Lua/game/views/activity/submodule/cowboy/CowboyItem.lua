slot0 = class("CowboyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if manager.time:GetServerTime() < uv0.stopTime_ and uv0.startTime_ <= slot0 then
			CowboyData:SetOpen(uv0.activityID_)
			SetActive(uv0.redGo_, false)
			CowboyAction:RefreshOpen(uv0.activityID_)
			JumpTools.OpenPageByJump("cowboyReady", {
				mainActivityID = uv0.mainActivityID_,
				activityID = uv0.activityID_,
				index = uv0.index_
			})
		elseif manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.mainActivityID_ = slot1
	slot0.activityID_ = slot2

	slot0:RefreshData()
	slot0:RefreshTime()
end

function slot0.RefreshData(slot0)
	slot0.data_ = CowboyData:GetData(slot0.activityID_)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)

	if slot0.data_ and slot0.activityData_:IsActivitying() and not CowboyData:GetOpen(slot0.activityID_) then
		SetActive(slot0.redGo_, true)
	else
		SetActive(slot0.redGo_, false)
	end

	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ and slot0.activityData_:IsActivitying() == false then
		slot0.stateCon_:SetSelectedState("close")

		slot0.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv1.startTime_))
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot0.data_ and slot0.data_.score > -10000 then
		slot0.stateCon_:SetSelectedState("finish")

		slot0.score_.text = slot0.data_.score
	else
		slot0.stateCon_:SetSelectedState("open")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshLevelText(slot0, slot1)
	slot0.index_ = slot1
	slot0.levelText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), slot1)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
