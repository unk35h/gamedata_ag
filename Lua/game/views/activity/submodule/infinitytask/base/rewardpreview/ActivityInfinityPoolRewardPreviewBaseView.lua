slot0 = class("ActivityInfinityPoolRewardPreviewBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisRewardUI"
end

function slot0.GetRewardPreviewItem(slot0)
	return ActivityInfinityPoolRewardPreviewBaseItem
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.mainRewardList_ = {}
	slot0.normalRewardList_ = {}
end

function slot0.OnEnter(slot0)
	if OsirisInfinityPoolData:GetPoolData(slot0.params_.poolID).coreItem == nil then
		SetActive(slot0.goMainItem_, false)
	else
		slot6 = true

		SetActive(slot0.goMainItem_, slot6)

		for slot6 = 1, 1 do
			slot7 = slot2.coreItem

			if slot0.mainRewardList_[slot6] == nil then
				slot0.mainRewardList_[slot6] = slot0:GetRewardPreviewItem().New(slot0.goItem_, slot0.goMainParent_, slot7, slot2.isOpenCoreItem and 1 or 0, 1)
			else
				slot0.mainRewardList_[slot6]:SetData(slot7, slot2.isOpenCoreItem and 1 or 0, 1)
			end
		end
	end

	for slot6 = 1, #slot2.resultItemList do
		slot8 = slot2.resultItemList[slot6].reward

		if slot0.normalRewardList_[slot6] == nil then
			slot0.normalRewardList_[slot6] = slot0:GetRewardPreviewItem().New(slot0.goItem_, slot0.goNormalParent_, slot8, slot7.cnt, slot7.maxCnt)
		else
			slot0.normalRewardList_[slot6]:SetData(slot8, slot7.cnt, slot7.maxCnt)
		end
	end

	for slot6 = #slot2.resultItemList + 1, #slot0.normalRewardList_ do
		slot0.normalRewardList_[slot6]:Show(false)
	end

	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.mainRewardList_) do
		slot5:Dispose()
	end

	slot0.mainRewardList_ = nil

	for slot4, slot5 in pairs(slot0.normalRewardList_) do
		slot5:Dispose()
	end

	slot0.normalRewardList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnClose_, nil, function ()
		uv0:Back()
	end)
end

return slot0
