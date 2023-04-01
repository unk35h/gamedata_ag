slot0 = class("FishingExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.PrefabList_ = {
		"UI/Fishing/Pages/FishingGivePageUI",
		"UI/Fishing/Pages/FishingReceivePageUI",
		"UI/Fishing/Pages/FishingRequirePageUI"
	}
	slot0.Classes_ = {
		FishingGivePageView,
		FishingReceivePageView,
		FishingRequirePageView
	}
	slot0.pages_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_
	}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SwitchToPage(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.SwitchToPage(slot0, slot1)
	if slot1 == slot0.curPageIndex_ then
		return
	end

	if slot0.pages_[slot0.curPageIndex_] then
		SetActive(slot0.pages_[slot0.curPageIndex_].gameObject_, false)
	end

	slot0.curPageIndex_ = slot1

	if not slot0.pages_[slot1] then
		slot0.pages_[slot1] = slot0.Classes_[slot1].New(Object.Instantiate(Asset.Load(slot0.PrefabList_[slot1]), slot0.container_))

		slot0:CheckPageEnter(slot1)
	else
		SetActive(slot0.pages_[slot1].gameObject_, true)
	end

	slot0.toggles_[slot1].isOn = true
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	FriendsAction:TryToRefreshFriendsView(1, function ()
		uv0:AddEventListeners()

		for slot3, slot4 in pairs(uv0.pages_) do
			uv0:CheckPageEnter(slot3)
		end

		uv0:SwitchToPage(uv0.params_.page or 1)
	end)
	manager.redPoint:bindUIandKey(slot0.redPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.OnExit(slot0)
	slot4 = slot0.redPointContainer_
	slot5 = RedPointConst.FISHING_RECEIVE_REWARD

	manager.redPoint:unbindUIandKey(slot4, slot5)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:OnExit()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
