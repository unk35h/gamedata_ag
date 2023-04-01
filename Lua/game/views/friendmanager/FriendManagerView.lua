slot0 = class("FriendManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friend/FriendManagerUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot5 = NAVI_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot5
	})

	slot4 = slot0.params_.fType
	slot0.model_ = slot0.selector_.compute(gameStore.getState(), slot4)

	for slot4, slot5 in ipairs(slot0.btnView_) do
		slot5:OnEnter()
	end

	slot0.friendSearchView_:OnEnter()
	slot0.friendRightContentView_:OnEnter()
	slot0:RefreshStyle()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.btnView_) do
		slot5:OnExit()
	end

	slot0.friendSearchView_:OnExit()
	slot0.friendRightContentView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in ipairs(slot0.btnView_) do
		slot5:Dispose()
	end

	slot0.btnView_ = nil

	slot0.friendSearchView_:Dispose()

	slot0.friendSearchView_ = nil

	slot0.friendRightContentView_:Dispose()

	slot0.friendRightContentView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.btnView_ = {
		FriendSwitchBtnView.New(slot0:FindGo("Panel/switchPanel/searchBtn"), 1),
		FriendSwitchBtnView.New(slot0:FindGo("Panel/switchPanel/newFriendBtn"), 2),
		FriendSwitchBtnView.New(slot0:FindGo("Panel/switchPanel/recommendBtn"), 3),
		FriendSwitchBtnView.New(slot0:FindGo("Panel/switchPanel/blackListBtn"), 4)
	}
	slot0.searchPanel_ = slot0:FindGo("Panel/searchPanel")
	slot0.rightContentPanel_ = slot0:FindGo("Panel/rightContentPanel")
	slot0.friendSearchView_ = FriendSearchView.New(slot0.searchPanel_, slot0.params_.fType)
	slot0.friendRightContentView_ = FriendRightContentView.New(slot0.rightContentPanel_, slot0.params_.fType)
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		fType = function (slot0, slot1)
			return slot1
		end
	})
end

function slot0.OnUpdate(slot0)
	slot0:OnSubscribe()
end

function slot0.OnSubscribe(slot0)
	if slot0.model_.fType ~= slot0.selector_.compute(gameStore.getState(), slot0.params_.fType).fType then
		slot0.model_.fType = slot1.fType

		slot0:RefreshStyle()
	end
end

function slot0.RefreshStyle(slot0)
	for slot4, slot5 in ipairs(slot0.btnView_) do
		slot5:SetBtnType(slot0.model_.fType)
	end

	slot0.friendSearchView_:SetFriendSwitchType(slot0.model_.fType)
	slot0.friendRightContentView_:SetFriendSwitchType(slot0.model_.fType)
end

return slot0
