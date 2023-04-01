slot0 = class("HellaHeroGiftView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/HellaHeroGiftUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.receivedController = ControllerUtil.GetController(slot0.transform_, "recevied")
	slot0.item = CommonItem.New(slot0.m_item)
	slot0.item2 = CommonItem.New(slot0.m_item2)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.activity_id) then
			HeroGiftAction.QueryReceiveHeroGift(uv0.activity_id)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = ActivityConst.HELLA_HERO_GIFT

	slot0:Refresh()

	if ActivityData:GetActivityIsOpen(slot0.activity_id) then
		slot0.timer = Timer.New(function ()
			uv0:OnTimerEvent()
		end, 1, -1)

		slot0.timer:Start()
	end

	slot0:OnTimerEvent()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnTimerEvent(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function slot0.Refresh(slot0)
	if HeroGiftData:GetReceiveHeroGift(slot0.activity_id) == 0 then
		slot0.receivedController:SetSelectedIndex(0)
	else
		slot0.receivedController:SetSelectedIndex(1)
	end

	if ActivityHeroGiftCfg[slot0.activity_id] then
		slot0:RefreshItem(slot2.reward[1], slot0.item)
		slot0:RefreshItem(slot2.reward[2], slot0.item2)
	end
end

function slot0.RefreshItem(slot0, slot1, slot2)
	if slot1 then
		slot2:RefreshData(formatReward(slot1))
		slot2:RegistCallBack(function ()
			ShowPopItem(POP_ITEM, uv0)
		end)
		slot2:Show(true)
	else
		slot2:Show(false)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end

	if slot0.item2 then
		slot0.item2:Dispose()

		slot0.item2 = nil
	end
end

function slot0.OnHeroGiftReward(slot0)
	slot0:Refresh()
end

return slot0
