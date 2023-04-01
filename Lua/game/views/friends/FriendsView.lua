slot0 = class("FriendsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/FriendsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	slot0.toggleS_ = {
		slot0.myFriendsTgl_,
		slot0.newFriendsTgl_,
		slot0.friendsRequestTgl_,
		slot0.blackListTgl_
	}
	slot0.friendsRightContentPanel_ = FriendsRightContentView.New(slot0.rightContentPanel_)
	slot0.pageCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pageCon")
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in pairs(slot0.toggleS_) do
		slot6 = slot5.onValueChanged

		slot6:AddListener(function (slot0)
			if slot0 and uv0 ~= uv1.curPageIndex_ then
				uv1:RefreshUI(uv0)
			end
		end)
	end

	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
end

function slot0.OnEnter(slot0)
	slot0.params_.friendPage = slot0.params_.friendPage or slot0.friendType_.myFriends

	slot0.friendsRightContentPanel_:OnEnter()
	slot0:UpdateNotice()

	if slot0.params_.friendPage ~= slot0.friendType_.search then
		slot0.toggleS_[slot0.params_.friendPage].isOn = true
		slot0.curPageIndex_ = slot0.params_.friendPage
	else
		slot0.toggleS_[slot0.friendType_.newFriends].isOn = true
		slot0.curPageIndex_ = slot0.friendType_.search
	end

	slot0:RefreshUI(slot0.curPageIndex_)
end

function slot0.UpdateNotice(slot0)
	manager.redPoint:bindUIandKey(slot0.toggleS_[1].transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:bindUIandKey(slot0.toggleS_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.isRefreshing_ = true
	slot0.curPageIndex_ = slot1
	slot0.params_.friendPage = slot0.curPageIndex_

	if slot0.curPageIndex_ == slot0.friendType_.myFriends then
		FriendsAction:TryToRefreshFriendsView(1)
	elseif slot0.curPageIndex_ == slot0.friendType_.newFriends or slot0.curPageIndex_ == slot0.friendType_.search then
		if slot0.curPageIndex_ == slot0.friendType_.newFriends and not slot0.newFriendsFresh then
			slot0.newFriendsFresh = true

			FriendsAction:TryToRefreshNewFriendsList(1)
		else
			slot0.friendsRightContentPanel_:RefreshUI(slot0.curPageIndex_)

			slot0.isRefreshing_ = false
		end
	elseif slot0.curPageIndex_ == slot0.friendType_.friendsRequest then
		FriendsAction:TryToRefreshFriendsView(2)
	elseif slot0.curPageIndex_ == slot0.friendType_.blackList then
		FriendsAction:TryToRefreshFriendsView(3)
	end

	slot0.pageCon_:SetSelectedState(slot0.curPageIndex_)
end

function slot0.OnTop(slot0)
	slot0:InitBar()
	slot0:CheckCooperationInviteEntry()
end

function slot0.InitBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnFriendsListChange(slot0, slot1)
	if slot0.curPageIndex_ == slot0.friendType_.newFriends and slot1 == slot0.friendType_.search then
		slot0.curPageIndex_ = slot0.friendType_.search
	end

	slot0.params_.friendPage = slot0.curPageIndex_

	slot0.friendsRightContentPanel_:RefreshUI(slot0.curPageIndex_)

	slot0.isRefreshing_ = false
end

function slot0.OnFriendsChatChange(slot0, slot1, slot2, slot3)
	if slot0.isRefreshing_ then
		return
	end

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		slot0.friendsRightContentPanel_:OnFriendsChatChange(slot1, slot2, slot3)
	end
end

function slot0.OnFriendsUnreadChange(slot0, slot1, slot2)
	if slot0.isRefreshing_ then
		return
	end

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		slot0.friendsRightContentPanel_:OnFriendsUnreadChange(slot1, slot2)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.friendsRightContentPanel_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.toggleS_[1].transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.redPoint:unbindUIandKey(slot0.toggleS_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.friendsRightContentPanel_:Dispose()

	for slot4, slot5 in pairs(slot0.toggleS_) do
		slot5.onValueChanged:RemoveAllListeners()
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
