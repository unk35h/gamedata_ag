slot1 = {
	myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
	newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
	friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
	blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
	search = FriendsConst.FRIEND_TYPE.SEARCH
}
slot2 = manager.net

slot2:Bind(19001, function (slot0)
	if #(slot0.friend_list or {}) > 0 then
		FriendsData:MyFriendsRefresh(slot1)
	end

	if #(slot0.request_list or {}) > 0 then
		FriendsData:FriendsRequestRefresh(slot2)
	end

	if #(slot0.black_list or {}) > 0 then
		FriendsData:BlackListRefresh(slot3)
	end

	FriendsAction:OnFriendsDataChange(0)
	FriendsAction:UpdateFriendsRedTip()
end)

slot2 = manager.net

slot2:Bind(19019, function (slot0)
	FriendsData:RefreshFriendsRequestList(slot0.request)
	FriendsAction:OnFriendsDataChange(uv0.friendsRequest)
	FriendsAction:UpdateFriendsRequestRedTip()
end)

slot2 = manager.net

slot2:Bind(19021, function (slot0)
	FriendsData:RefreshMyFriendsList(slot0.friend)
	FriendsAction:OnFriendsDataChange(uv0.myFriends)
	FriendsAction:UpdateFriendsRedTip()
end)

slot2 = manager.net

slot2:Bind(19023, function (slot0)
	FriendsData:DelectFromMyFriendsList(slot0.friend_id)
	FriendsAction:OnFriendsDataChange(uv0.myFriends)
	FriendsAction:UpdateChatRedTip()
	FriendsAction:OnFriendsDelect(slot0.friend_id)
	ChatAction.DeleteFriendChat(slot0.friend_id)
end)

slot2 = manager.net

slot2:Bind(19027, function (slot0)
	FriendsData:DelectID(slot0.friend_id)
	FriendsAction:OnFriendsDataChange(uv0.myFriends)
	FriendsAction:UpdateFriendsRedTip()
	FriendsAction:OnFriendsDelect(slot0.friend_id)
	ChatAction.DeleteFriendChat(slot0.friend_id)
	ChatAction.RefreshWorldChatData()
end)

slot2 = manager.net

slot2:Bind(19029, function (slot0)
	manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, slot0.request_num)
	FriendsData:FriendsDataInit(slot0.brief_friend_list or {}, slot0.request_list or {}, slot0.black_list or {})
end)

slot2 = manager.net

slot2:Bind(19033, function (slot0)
	FriendsData:RefreshRecommend(slot0.recommend)
end)

return {
	TryToRequestToFriend = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19002, {
			request_user_id = slot1
		}, 19003, handler(slot0, slot0.OnTryToRequestToFriend))
	end,
	OnTryToRequestToFriend = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("FRIEND_APPLY_SEND")
			FriendsData:RequestToFriend(slot2.request_user_id)
			FriendsData:TryToAddRequest(slot2.request_user_id)
			FriendsAction:OnFriendsDataChange(uv0.newFriends)
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDealRequest = function (slot0, slot1, slot2)
		if slot2 == 1 then
			if not FriendsData:IsCanBeFriend(slot1) then
				return
			end
		else
			ShowTips("FRIEND_APPLY_REJECT")
		end

		manager.net:SendWithLoadingNew(19004, {
			request_user_id = slot1,
			deal = slot2
		}, 19005, handler(slot0, slot0.OnTryToDealRequest))
	end,
	OnTryToDealRequest = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DealRequest(slot2.request_user_id, slot2.deal, slot1.friend)
			FriendsAction:OnFriendsDataChange(uv0.friendsRequest)
			FriendsAction:UpdateFriendsRequestRedTip()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDelectFromMyFriendsList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19006, {
			friend_id = slot1
		}, 19007, handler(slot0, slot0.OnTryToDelectFromMyFriendsList))
	end,
	OnTryToDelectFromMyFriendsList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DelectFromMyFriendsList(slot2.friend_id)
			FriendsAction:OnFriendsDataChange(uv0.myFriends)
			FriendsAction:UpdateChatRedTip()
			ChatAction.DeleteFriendChat(slot2.friend_id)
		else
			ShowTips(slot1.result)
		end
	end,
	TryToAddToBlacklist = function (slot0, slot1)
		if FriendsData:IsCanBeBlackList(slot1) then
			manager.net:SendWithLoadingNew(19008, {
				black_user_id = slot1
			}, 19009, handler(slot0, slot0.OnTryToAddToBlacklist))
		end
	end,
	OnTryToAddToBlacklist = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:AddToBlacklist(slot1.black)
			FriendsData:TryToRemoveRequest(slot2.friend_id)
			FriendsAction:OnFriendsDataChange(uv0.myFriends)
			FriendsAction:UpdateFriendsRedTip()
			ChatAction.DeleteFriendChat(slot2.black_user_id)
			ChatAction.RefreshWorldChatData()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDelectFromBlackList = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(19010, {
			black_user_id = slot1,
			is_request = slot2
		}, 19011, handler(slot0, slot0.OnTryToDelectFromBlackList))
	end,
	OnTryToDelectFromBlackList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DelectFromBlackList(slot2.black_user_id, slot2.is_request)

			if slot2.isRequest == 1 then
				FriendsAction:OnFriendsDataChange(uv0.newFriends)
			else
				FriendsAction:OnFriendsDataChange(uv0.blackList)
			end

			ChatAction.RefreshWorldChatData()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToSearchFriend = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19012, {
			user_id = slot1
		}, 19013, handler(slot0, slot0.OnTryToSearchFriend))
	end,
	OnTryToSearchFriend = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:SetSearchList(slot1.user_info)
			FriendsAction:OnFriendsDataChange(uv0.search)
		else
			FriendsData:SetSearchList()
			FriendsAction:OnFriendsDataChange(uv0.search)
			ShowTips(slot1.result)
		end
	end,
	TryToDealRequestList = function (slot0, slot1)
		if FriendsData:GetListLength(uv0.friendsRequest) == 0 then
			return
		end

		if slot1 == 2 then
			ShowTips("IGNORE_ALL_FRIEND_REQUEST")
		end

		manager.net:SendWithLoadingNew(19014, {
			deal = slot1
		}, 19015, handler(slot0, slot0.OnTryToDealRequestList))
	end,
	OnTryToDealRequestList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DealRequestList(slot1.friend_list or {}, slot2.deal)
			FriendsAction:OnFriendsDataChange(uv0.friendsRequest)
			FriendsAction:UpdateFriendsRequestRedTip()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToRefreshNewFriendsList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19016, {
			cmd = slot1
		}, 19017, handler(slot0, slot0.OnTryToRefreshNewFriendsList))
	end,
	OnTryToRefreshNewFriendsList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:RefreshNewFriendsList(slot1.recommend_list or {})
			FriendsAction:OnFriendsDataChange(uv0.newFriends)
		else
			ShowTips(slot1.result)

			if slot2.cmd == 1 then
				FriendsData:RefreshNewFriendsList({})
				FriendsAction:OnFriendsDataChange(uv0.newFriends)
			end
		end
	end,
	TryToRefreshFriendsView = function (slot0, slot1, slot2)
		slot0.func = slot2

		manager.net:SendWithLoadingNew(19030, {
			type = slot1
		}, 19031, handler(slot0, slot0.OnTryToRefreshFriendsView))
	end,
	OnTryToRefreshFriendsView = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			if slot0.func then
				slot0.func()

				slot0.func = nil
			end
		else
			ShowTips(slot1.result)
		end
	end,
	RefreshChat = function (slot0, slot1, slot2, slot3)
		FriendsData:RefreshChat(slot1, slot2, slot3)
		manager.notify:CallUpdateFunc(FRIENDS_CHAT_CHANGE, slot1, slot2, slot3)
	end,
	RefreshUnread = function (slot0, slot1, slot2)
		FriendsData:RefreshUnread(slot1, slot2)
		manager.notify:CallUpdateFunc(FRIENDS_UNREAD_CHANGE, slot1, slot2)

		if slot2 == 0 then
			FriendsAction:UpdateChatRedTip()
		elseif manager.redPoint:getTipValue(RedPointConst.FRIEND_MY_FRIENDS) == 0 then
			manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, 1)
		end
	end,
	OnFriendsDelect = function (slot0, slot1)
		manager.notify:CallUpdateFunc(FRIENDS_DELECT, slot1)
	end,
	OnFriendsDataChange = function (slot0, slot1)
		manager.notify:CallUpdateFunc(FRIENDS_LIST_CHANGE, slot1)
	end,
	ChatInit = function (slot0)
		FriendsData:ChatInit()
	end,
	UpdateFriendsRedTip = function (slot0)
		slot0:UpdateChatRedTip()
		slot0:UpdateFriendsRequestRedTip()
	end,
	UpdateChatRedTip = function (slot0)
		slot1 = false

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
			slot1 = false
		end

		slot2 = FriendsData:GetChatList() or {}

		for slot6, slot7 in pairs(slot2) do
			if slot7.unReadMsgCnt > 0 then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, slot1 and 1 or 0)
	end,
	UpdateFriendsRequestRedTip = function (slot0)
		slot1 = false

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
			slot1 = false
		end

		if FriendsData:IsRequesting() then
			slot1 = true
		end

		manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, slot1 and 1 or 0)
		manager.redPoint:setTip(RedPointConst.FRIEND, slot1 and 1 or 0)
	end
}
