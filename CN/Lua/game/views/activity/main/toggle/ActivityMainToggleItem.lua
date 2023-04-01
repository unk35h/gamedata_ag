slot0 = class("ActivityMainToggleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.toggleID_ = slot3
	slot0.activityID_ = slot4
	slot0.redPointActivityID_ = slot5 or slot4

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.subTitleController_ = ControllerUtil.GetController(slot0.transform_, "subTitle")
	slot0.updateHandler_ = handler(slot0, slot0.UpdateActivity)

	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	slot0.activiteData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activiteData_.startTime

	if ActivityShopCfg[slot0.activityID_] then
		slot0.stopTime_ = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot0.activityID_].shop_id].activity_id).stopTime
	else
		slot0.stopTime_ = slot0.activiteData_.stopTime
	end

	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	manager.redPoint:bindUIandKey(slot0.transform_, ActivityTools.GetRedPointKey(slot0.redPointActivityID_) .. slot0.redPointActivityID_)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, ActivityTools.GetRedPointKey(slot0.redPointActivityID_) .. slot0.redPointActivityID_)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.updateHandler_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
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

		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_CLICK, uv0.activityID_)
	end)
end

function slot0.OnSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(tostring(slot1))
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

	if slot1 or slot2 then
		if slot0.gameObject_.activeSelf == true then
			SetActive(slot0.gameObject_, false)
		end
	elseif slot0.gameObject_.activeSelf == false then
		SetActive(slot0.gameObject_, true)
	end
end

function slot0.RefreshTime(slot0)
	if slot0.textTime_ then
		slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	end
end

function slot0.UpdateActivity(slot0, slot1)
	if slot0.activityID_ == slot1 then
		slot0.activiteData_ = ActivityData:GetActivityData(slot0.activityID_)
		slot0.startTime_ = slot0.activiteData_.startTime

		if ActivityShopCfg[slot0.activityID_] then
			slot0.stopTime_ = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot0.activityID_].shop_id].activity_id).stopTime
		else
			slot0.stopTime_ = slot0.activiteData_.stopTime
		end

		slot0:AddTimer()
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshLock()
	slot0:RefreshTime()

	slot1 = manager.time:GetServerTime() < slot0.startTime_

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, slot0.activityID_)

		return
	end

	slot0.timer_ = Timer.New(function ()
		slot0 = manager.time:GetServerTime()

		if uv0 and uv1.startTime_ < slot0 then
			uv1:RefreshLock()

			uv0 = false
		elseif uv1.stopTime_ <= slot0 then
			uv1:RefreshLock()
			uv1:StopTimer()
			manager.notify:Invoke(ACTIVITY_MAIN_TOGGLE_OVER, uv1.activityID_)

			return
		end

		uv1:RefreshTime()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshUI(slot0)
	if ActivityToggleCfg[slot0.toggleID_].sub_title_type == 0 then
		slot0.subTitleController_:SetSelectedState("false")
	else
		slot0.subTitleController_:SetSelectedState("true")

		if slot2 == 1 then
			slot0.subTitleText_.text = GetTips("MAIN_PLOT_TEXT")
		elseif slot2 == 2 then
			slot0.subTitleText_.text = GetTips("SUB_PLOT_TEXT")
		end
	end

	slot0.nameText_.text = slot1.name
	slot0.iconImage_.sprite = getSprite("Atlas/Activity", slot1.icon)
end

return slot0
