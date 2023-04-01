slot0 = class("SkinExchangeView", ReduxView)

function slot0.UIName(slot0)
	return SkinExchangeTool.GetMainUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costList_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SkinExchangeCostItem)
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.costList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.activityData_:IsActivitying() then
			slot0, slot1 = SkinExchangeTool.IsCanExchange(uv0.activityID_)

			if slot0 then
				SkinExchangeAction:ExchangeSkin(uv0.activityID_)
			else
				ShowTips(slot1)
			end
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:GetActivityData()
	slot0:RefreshData()
	slot0:BindRedPointUI()
end

function slot0.GetActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshData(slot0)
	slot0:RefreshCost()
	slot0:RefreshState()
	slot0:RefreshTime()
end

function slot0.RefreshCost(slot0)
	slot0.cfg_ = ActivitySkinExchangeCfg[slot0.activityID_]
	slot0.costList_ = slot0.cfg_.cost

	slot0.scrollHelper_:StartScroll(#slot0.costList_)
end

function slot0.RefreshState(slot0)
	if SkinExchangeData:GetState(slot0.activityID_) == 1 then
		slot0.stateCon_:SetSelectedState("finish")
	else
		slot0.stateCon_:SetSelectedState("unfinish")
	end
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ and slot0.activityData_.state == 0 then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot0.startTime_ <= slot2 and slot0.activityData_.state == 0 then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0:StopTimer()
			uv0:RefreshTime()
		end, 10, 1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_, true)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_, true)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.OnActivitySkinExchange(slot0)
	slot0:RefreshData()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. slot0.activityID_)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_.transform, RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. slot0.activityID_)
end

function slot0.OnTop(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.cfg_.cost) do
		table.insert(slot1, slot6[1])
	end

	slot2 = {
		BACK_BAR,
		HOME_BAR
	}

	table.insertto(slot2, slot1)

	slot6 = slot2

	manager.windowBar:SwitchBar(slot6)

	for slot6, slot7 in ipairs(slot1) do
		manager.windowBar:SetBarCanAdd(slot7, true)
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
