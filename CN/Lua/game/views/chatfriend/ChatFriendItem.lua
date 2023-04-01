slot1 = class("ChatFriendItem", import("game.views.chat.chatItem.ChatBaseItemView"))

function slot1.Init(slot0)
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.onlineController_ = ControllerUtil.GetController(slot0.rectOnlineState_, "conName")
	slot0.textExtension_ = slot0.goContent_:GetComponent(typeof(TextExtension))
	slot0.canRemoveFlag_ = true
	slot0.refreshRedPointHandler_ = handler(slot0, slot0.RefreshRedPoint)
	slot0.refreshAllHandler_ = handler(slot0, slot0.RefreshAll)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonGo_, nil, function ()
		uv0:Go("/chatFriend", {
			friendID = uv0.friendID_
		})
	end)

	slot1 = slot0.scrollView_.onValueChanged

	slot1:AddListener(function (slot0)
		if slot0.x == 0 or slot0.x == 1 then
			uv0.canRemoveFlag_ = true
		end

		if uv0.canRemoveFlag_ == false then
			uv0.scrollView_.horizontalNormalizedPosition = 0

			LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.rectScrollView_)
		end

		if math.abs(slot0.x) > 350 and uv0.canRemoveFlag_ then
			uv0.canRemoveFlag_ = false

			uv0:Show(false)
			manager.notify:Invoke(CHAT_FRIEND_CLOSE_ITEM, uv0.friendID_)
			ChatFriendData:SaveRecordCnt(uv0.friendID_)
			FriendsAction:RefreshUnread(uv0.friendID_, 0)
		end
	end)
end

function slot1.RefreshText(slot0, slot1)
	slot3 = ""
	slot4 = ChatFriendData:GetFriendList(slot1).timestamp

	if ChatFriendData:GetLastMsgData(slot1) then
		slot3 = (slot5.contentType ~= ChatConst.CHAT_CONTENT_TYPE.STICKER or string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot5.content)].name))) and slot5.content

		if slot5.timestamp then
			slot4 = slot5.timestamp
		end
	end

	slot0.textExtension_:SetText(slot3)

	slot0.textTime_.text = manager.time:FormatTime(slot4)
end

function slot1.RefreshRedPoint(slot0, slot1)
	if slot0.friendID_ == slot1 then
		if ChatFriendData:GetUnreadMsgCnt(slot1) <= 0 then
			SetActive(slot0.goNotice_, false)
		else
			SetActive(slot0.goNotice_, true)

			slot0.textNoticeCnt_.text = slot2
		end
	end
end

function slot1.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		if not slot0.isRegister_ then
			manager.notify:RegistListener(CHAT_FRIEND_READ_MESSAGE, slot0.refreshRedPointHandler_)
			manager.notify:RegistListener(CHAT_FRIEND_CHAT_RESET, slot0.refreshAllHandler_)

			slot0.isRegister_ = true
		end
	elseif slot0.isRegister_ then
		manager.notify:RemoveListener(CHAT_FRIEND_READ_MESSAGE, slot0.refreshRedPointHandler_)
		manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, slot0.refreshAllHandler_)

		slot0.isRegister_ = false
	end
end

function slot1.SetData(slot0, slot1, slot2, slot3)
	slot0.friendID_ = slot1
	slot0.index_ = slot2

	slot0:RefreshHead(slot1)
	slot0:RefreshAll(slot1)
	slot0:SetSelectID(slot3)
	slot0:Show(true)

	slot0.scrollView_.horizontalNormalizedPosition = 0

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectScrollView_)
end

function slot1.RefreshAll(slot0, slot1)
	if slot0.friendID_ ~= slot1 then
		return
	end

	slot0:RefreshText(slot1)
	slot0:RefreshRedPoint(slot1)
end

function slot1.RefreshHead(slot0, slot1)
	if slot1 == USER_ID then
		slot2 = PlayerData:GetPlayerInfo()
		slot0.textNick_.text = slot2.nick
		slot0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot2.portrait].icon)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot2.icon_frame)
	else
		if FriendsData:GetInfoByID(slot1) == false then
			print("unfind friend data", slot1)
			slot0:Show(false)

			return
		end

		slot0.textNick_.text = slot2.nick
		slot0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot2.icon].icon)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot2.icon_frame)

		if slot2.online_state == 0 then
			slot0.onlineController_:SetSelectedState("on")
		else
			slot0.onlineController_:SetSelectedState("off")
		end
	end
end

function slot1.GetFriendID(slot0)
	return slot0.friendID_
end

function slot1.SetSelectID(slot0, slot1)
	if slot1 == slot0.friendID_ then
		slot0.selectController_:SetSelectedState("selected")
	else
		slot0.selectController_:SetSelectedState("nor")
	end
end

function slot1.Dispose(slot0)
	if slot0.isRegister_ then
		manager.notify:RemoveListener(CHAT_FRIEND_READ_MESSAGE, slot0.refreshRedPointHandler_)
		manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, slot0.refreshAllHandler_)

		slot0.isRegister_ = false
	end

	slot0.refreshRedPointHandler_ = nil
	slot0.refreshAllHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
