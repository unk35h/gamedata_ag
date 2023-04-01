slot0 = class("RegressionGiftView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ReturnUI/RegressionGiftUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.receivedController = ControllerUtil.GetController(slot0.transform_, "received")
	slot0.rewardList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		RegressionAction.QueryRegressionGift()
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		if RegressionData:GetRegressionGiftReceive() then
			uv0:Back()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.gifts = RegressionCfg[RegressionData:GetRegressionVersion()] and RegressionCfg[slot1].gift or {}

	slot0.rewardList:StartScroll(#slot0.gifts)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.receivedController:SetSelectedIndex(RegressionData:GetRegressionGiftReceive() and 1 or 0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.gifts[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	slot0.rewardList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnRegressionGiftReward(slot0)
	slot0:Refresh()
end

return slot0
