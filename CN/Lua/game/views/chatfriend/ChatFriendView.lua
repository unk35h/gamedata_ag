slot0 = class("ChatFriendView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/FriendsChatUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitItemPool()

	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.scrollView_, slot0.rectGrid_, slot0.viewPort_.rect.height, slot0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing, true)
	slot0.chatFriendContentView_ = ChatFriendContentView.New(slot0.goRigthPanel_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = 1
	slot0.selectID_ = slot0.params_.friendID or ChatFriendData:GetCacheHeroList()[1]

	if slot0.selectID_ then
		slot1 = table.keyof(ChatFriendData:GetCacheHeroList(), slot0.selectID_)
	end

	ChatFriendData:LockFriendID(slot0.selectID_)
	slot0.chatFriendContentView_:OnEnter(slot0.selectID_)
	slot0.loopScrollView_:NavigateIndex(slot1)

	slot0.newMsgHandler_ = handler(slot0, slot0.OnReceiveMsg)

	manager.notify:RegistListener(CHAT_FRIEND_NEW_MESSAGE, slot0.newMsgHandler_)

	slot0.closeFriendItemHandler_ = handler(slot0, slot0.OnCloseFriendItem)

	manager.notify:RegistListener(CHAT_FRIEND_CLOSE_ITEM, slot0.closeFriendItemHandler_)
end

function slot0.OnUpdate(slot0)
	slot0.selectID_ = slot0.params_.friendID or ChatFriendData:GetCacheHeroList()[1]

	ChatFriendData:LockFriendID(slot0.selectID_)
	slot0.chatFriendContentView_:OnUpdate(slot0.selectID_)
	slot0:RefresItemList()
end

function slot0.OnExit(slot0)
	ChatFriendData:LockFriendID(0)
	manager.notify:RemoveListener(CHAT_FRIEND_NEW_MESSAGE, slot0.newMsgHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_CLOSE_ITEM, slot0.closeFriendItemHandler_)
	slot0.chatFriendContentView_:OnExit()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.loopScrollView_:Dispose()

	slot0.loopScrollView_ = nil

	slot0.chatFriendContentView_:Dispose()

	slot0.chatFriendContentView_ = nil

	slot0:DisposeItemPool()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.OnReceiveMsg(slot0, slot1)
	slot2 = slot0:LsGetItemData()

	for slot7, slot8 in ipairs(slot0.loopScrollView_:GetItemList()) do
		slot8.itemView:SetData(slot8.itemView:GetFriendID(), table.keyof(slot2, slot8.itemView:GetFriendID()), slot0.selectID_)
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8.itemView:GetFriendID() == slot1 then
			slot0.loopScrollView_:DeleteIndex(slot7)

			break
		end
	end

	slot0.loopScrollView_:RefreshScrollView()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGrid_)
end

function slot0.OnCloseFriendItem(slot0, slot1)
	ChatFriendData:RemoveCacheHero(slot1)
	slot0.loopScrollView_:RefreshScrollView()

	if slot1 == slot0.selectID_ then
		if #ChatFriendData:GetCacheHeroList() <= 0 then
			slot0:Back()
		else
			slot0:Go("/chatFriend", {
				friendID = slot2[1]
			})
		end
	end
end

function slot0.InitItemPool(slot0)
	slot0.itemPool_ = {}
end

function slot0.RefresItemList(slot0)
	for slot4, slot5 in pairs(slot0.itemPool_) do
		if slot5.isFree == false then
			slot5.itemView:SetSelectID(slot0.selectID_)
		end
	end
end

function slot0.GetFreeItem(slot0)
	for slot4, slot5 in pairs(slot0.itemPool_) do
		if slot5.isFree == true then
			slot5.isFree = false

			return slot5
		end
	end

	slot2 = {
		isFree = false,
		itemView = ChatFriendItem.New(slot0.goItem_, slot0.goItemParent_)
	}

	table.insert(slot0.itemPool_, slot2)

	return slot2
end

function slot0.DisposeItemPool(slot0)
	for slot4, slot5 in ipairs(slot0.itemPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemPool_ = nil
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot3 = slot0:GetFreeItem()

	slot3.itemView:SetData(slot1, slot2, slot0.selectID_)

	return slot3
end

function slot0.LsUpdateItem(slot0, slot1, slot2, slot3)
	slot1.itemView:SetData(slot2, slot3, slot0.selectID_)
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.LsGetItemData(slot0)
	return ChatFriendData:GetCacheHeroList()
end

return slot0
