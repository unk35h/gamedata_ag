slot0 = class("FriendsItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "friendType")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "online")
	slot0.newFriendCon_ = ControllerUtil.GetController(slot0.transform_, "newFriend")
	slot0.messageCon_ = ControllerUtil.GetController(slot0.transform_, "message")

	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.textLimit_ = slot0.chatText_.gameObject:GetComponent("TextExtension")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.userID)
	end)
	slot0:AddBtnListener(slot0.chatBtn_, nil, function ()
		ChatFriendData:AddCacheFriend(uv0.userID)
		uv0:Go("/chatFriend", {
			friendID = uv0.userID
		})
	end)
	slot0:AddBtnListener(slot0.addFriendBtn_, nil, function ()
		if FriendsData:IsCanBeFriend(uv0.userID) then
			FriendsAction:TryToRequestToFriend(uv0.userID)
		end
	end)
	slot0:AddBtnListener(slot0.requestAcceptBtn_, nil, function ()
		FriendsAction:TryToDealRequest(uv0.userID, 1)
	end)
	slot0:AddBtnListener(slot0.requestIgnoreBtn_, nil, function ()
		FriendsAction:TryToDealRequest(uv0.userID, 2)
	end)
	slot0:AddBtnListener(slot0.shiftoutBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("BLACKLIST_REMOVE_QUEST"), uv0.data_.nick),
			OkCallback = function ()
				FriendsAction:TryToDelectFromBlackList(uv0.userID, 2)
			end
		})
	end)
	slot0:AddBtnListener(slot0.reportBtn_, nil, function ()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = uv0.data_.nick,
				userID = uv0.data_.user_id
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.copyBtn_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userID

		ShowTips("COPY_SUCCESS")
	end)
end

function slot0.OnEnter(slot0)
	slot0.data_ = {}
end

function slot0.RefreshUI(slot0, slot1, slot2)
	if slot1 == nil then
		return
	end

	slot0.data_ = slot1
	slot0.curType_ = slot2

	slot0.typeCon_:SetSelectedState(slot0.curType_)

	slot0.userID = slot1.user_id
	slot0.idTxt_.text = slot1.user_id
	slot0.nameText_.text = slot1.nick
	slot0.headIcon_.sprite = ItemTools.getItemSprite(slot1.icon)

	slot0.headIcon_:SetNativeSize()

	slot0.data_.icon_frame = slot0.data_.icon_frame ~= 0 and slot0.data_.icon_frame or 2001
	slot0.frameIcon_.sprite = ItemTools.getItemSprite(slot0.data_.icon_frame)

	if slot0.curType_ ~= slot0.friendType_.friendsRequest and slot0.curType_ ~= slot0.friendType_.blackList then
		if (slot1.online_state or -1) == 0 then
			slot0.stateCon_:SetSelectedState("on")

			slot0.offlineText_.text = GetTips("ONLINE")
		else
			if manager.time:GetServerTime() - slot3 < 3600 then
				slot0.offlineText_.text = GetTips("FRIEND_ONLINE_TIME_WITHIN_AN_HOUR")
			elseif slot4 < 86400 then
				slot0.offlineText_.text = GetTips("FRIEND_ONLINE_TIME_IN_ONE_DAY")
			elseif slot4 < 2592000 then
				slot0.offlineText_.text = string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), math.floor(slot4 / 86400))
			else
				slot0.offlineText_.text = string.format(GetTips("FRIEND_ONLINE_TIME_ONE_DAY_AGO"), 30)
			end

			slot0.stateCon_:SetSelectedState("off")
		end
	end

	if slot0.curType_ == slot0.friendType_.myFriends then
		slot0.textLimit_:SetText(slot1.lastChat)

		if slot1.lastChatTime then
			slot0.chatTime_.text = manager.time:FormatTime(slot1.lastChatTime)
		else
			slot0.chatTime_.text = ""
		end

		slot3 = slot1.unReadMsgCnt
		slot0.unReadMsgText_.text = slot3

		slot0.messageCon_:SetSelectedState(slot3 == 0 and "clear" or "unread")
	else
		slot0.messageCon_:SetSelectedState("clear")

		if slot0.curType_ == slot0.friendType_.newFriends or slot0.curType_ == slot0.friendType_.search then
			slot0.newFriendsSign_.text = slot1.sign

			slot0.newFriendCon_:SetSelectedState(slot1.isDeal and 1 or 0)
		elseif slot0.curType_ == slot0.friendType_.friendsRequest then
			slot0.friendsRequestSign_.text = slot1.sign
		elseif slot0.curType_ ~= slot0.friendType_.blackList then
			print("未确认类型")
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
