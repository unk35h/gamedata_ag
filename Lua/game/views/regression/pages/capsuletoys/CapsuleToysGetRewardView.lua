slot0 = class("CapsuleToysGetRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ReturnTwoUI/RT2stBonusWindowsUI"
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

	slot0.rewardItemList_ = {}
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in ipairs(slot0.params_.list) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6, false)
		else
			slot0.rewardItemList_[slot5] = slot0:GetRewardItem(slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end

	if #slot1 > 5 then
		slot0.typeController_:SetSelectedIndex(1)
	else
		slot0.typeController_:SetSelectedIndex(0)
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goRewardPanel_, slot1, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.rewardItemList_ then
		for slot4, slot5 in ipairs(slot0.rewardItemList_) do
			slot5:Dispose()
		end

		slot0.rewardItemList_ = nil
	end
end

return slot0
