slot0 = class("RegressionNewGiftView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ReturnTwoUI/RT2stGift2UI"
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
	slot0.rewardItems_ = {}
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

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.receivedController:SetSelectedIndex(RegressionData:GetRegressionGiftReceive() and 1 or 0)
	slot0:RefreshReward()
	slot0:RefreshTime()
end

function slot0.RefreshReward(slot0)
	for slot4, slot5 in ipairs(slot0.gifts) do
		if slot0.rewardItems_[slot4] == nil then
			slot0.rewardItems_[slot4] = RewardPoolNoobItem.New(slot0.m_rewardGo, slot0.rewardParent_, slot5, true)
		else
			slot0.rewardItems_[slot4]:SetData(slot5)
		end
	end

	for slot4 = #slot0.gifts + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Show(false)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnRegressionGiftReward(slot0)
	slot0:Refresh()
end

function slot0.RefreshTime(slot0)
	slot1 = RegressionData:GetLastOfflineTime()
	slot0.descText_.text = string.format(GetTips("REGRESSION_GIFT_DESCRIPE"), manager.time:STimeDescS(slot1, "!%Y/%m/%d"), manager.time:DiffDay2(slot1, RegressionData:GetRegressionLoginTime()))
end

return slot0
