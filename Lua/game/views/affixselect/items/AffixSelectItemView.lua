slot0 = class("AffixSelectItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:StartTimer()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btn_ = slot0.gameObject_:GetComponent(typeof(Button))
	slot0.item_stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "item_state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			slot2 = manager.time:GetServerTime()

			if ActivityData:GetActivityData(uv0.activityId_) and slot2 < slot1.startTime then
				ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot1.startTime)))
			else
				ShowTips("SOLO_TIME_OVER")
			end

			return
		end

		ActivityAffixSelectData:ReadInnerRedPoint(uv0.activityId_)
		JumpTools.OpenPageByJump("/affixSelectDetail", {
			activityId = uv0.activityId_,
			index = uv0.index_
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.activityId_ = slot2

	slot0:UpdateView()
end

function slot0.GetActivityData(slot0)
	return ActivityAffixSelectData:GetSubActivityData(slot0.activityId_)
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateView()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateView(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activityId_) or slot0:GetActivityData() == nil then
		slot0.item_stateController_:SetSelectedState("lock")

		if ActivityData:GetActivityData(slot0.activityId_).startTime <= manager.time:GetServerTime() then
			slot0.lockLabel_.text = GetTips("SOLO_TIME_OVER")
		else
			slot0.lockLabel_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot2.startTime))
		end
	else
		if slot0:GetActivityData().clearState == 1 then
			slot0.item_stateController_:SetSelectedState("unlock")
		else
			slot0.item_stateController_:SetSelectedState("passed")
		end

		slot0.highestScoreLabel_.text = slot0:GetActivityData().point
	end

	if slot1 and not ActivityAffixSelectData:HaveReadInnerPoint(slot0.activityId_) and slot0:GetActivityData().clearState == 1 then
		SetActive(slot0.noticeGo_, true)
	else
		SetActive(slot0.noticeGo_, false)
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
