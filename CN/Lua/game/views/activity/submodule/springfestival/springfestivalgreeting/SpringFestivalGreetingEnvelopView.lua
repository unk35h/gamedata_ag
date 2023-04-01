slot0 = class("SpringFestivalGreetingEnvelopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/letter/EDream_letterpop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.commonItemView_:Dispose()

	slot0.commonItemView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function slot0.RefreshUI(slot0)
	if slot0.commonItemView_ == nil then
		slot0.commonItemView_ = CommonItem.New(slot0.itemGo_)
	end

	slot1 = slot0:GetActivityID()
	slot3 = ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]

	slot0.commonItemView_:RefreshData(formatReward(ActivityPointRewardCfg[slot3[SpringFestivalGreetingData:GetUnlockCnt(slot1)]].reward_item_list[1]))
	slot0.commonItemView_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)

	slot0.cntText_.text = string.format("%s/%s", SpringFestivalGreetingData:GetReceiveCnt(slot1), #slot3)

	slot0:RefreshTimeText()
end

function slot0.RefreshTimeText(slot0)
	slot2 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot3 = slot2.startTime
	slot0.timeText_.text = string.format("%s——%s", manager.time:STimeDescS(slot3, "!%m/%d %H:%M"), manager.time:STimeDescS(slot2.stopTime, "!%m/%d %H:%M"))

	if manager.time:GetServerTime() < slot3 or slot4 < slot5 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
