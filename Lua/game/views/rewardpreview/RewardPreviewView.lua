slot0 = class("RewardPreviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupRewardPreviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.itemList_ = {}
	slot0.is_receive = slot0.params_.is_receive or false

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in pairs(slot0.params_.rewardList) do
		slot0.itemList_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

		slot0.itemList_[slot5]:UpdateCommonItemAni()
		slot0.itemList_[slot5]:SetData(slot6)

		if slot0.is_receive then
			slot0.itemList_[slot5]:ShowSelect(true)
		else
			slot0.itemList_[slot5]:ShowSelect(false)
		end
	end
end

return slot0
