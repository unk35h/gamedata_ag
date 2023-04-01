slot0 = class("ChatFriendContentView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:InitItemPool()

	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.scrollView_, slot0.rectGrid_, slot0.viewPort_.rect.height, slot0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing, true)

	slot0:AddListeners()

	slot0.onlineController_ = ControllerUtil.GetController(slot0.rectOnlineState_, "online")
	slot0.chatStickerView_ = ChatStickerView.New(slot0.goSticker_)
end

function slot0.OnEnter(slot0, slot1)
	slot0.friendID_ = slot1

	slot0.chatStickerView_:OnEnter()
	slot0:RefreshContent()

	slot0.sendStickerHandler_ = handler(slot0, slot0.OnSendSticker)

	manager.notify:RegistListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)

	slot0.newMsgHandler_ = handler(slot0, slot0.OnReceiveMsg)

	manager.notify:RegistListener(CHAT_FRIEND_NEW_MESSAGE, slot0.newMsgHandler_)

	slot0.chatReportHandler_ = handler(slot0, slot0.OnChatReport)

	manager.notify:RegistListener(CHAT_REPORT, slot0.chatReportHandler_)

	slot0.chatReportHideHandler_ = handler(slot0, slot0.OnHideChatReport)

	manager.notify:RegistListener(CHAT_REPORT_HIDE, slot0.chatReportHideHandler_)

	slot0.recallMsgHandler_ = handler(slot0, slot0.OnRecallMsg)

	manager.notify:RegistListener(CHAT_FRIEND_CHAT_RESET, slot0.recallMsgHandler_)
end

function slot0.OnUpdate(slot0, slot1)
	if slot0.friendID_ == slot1 then
		return
	end

	slot0.friendID_ = slot1

	slot0:RefreshContent()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_NEW_MESSAGE, slot0.newMsgHandler_)
	manager.notify:RemoveListener(CHAT_REPORT, slot0.chatReportHandler_)
	manager.notify:RemoveListener(CHAT_REPORT_HIDE, slot0.chatReportHideHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, slot0.recallMsgHandler_)
	slot0.chatStickerView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0:DisposeItemPool()

	slot0.sendStickerHandler_ = nil
	slot0.newMsgHandler_ = nil
	slot0.chatReportHandler_ = nil
	slot0.chatReportHideHandler_ = nil
	slot0.recallMsgHandler_ = nil

	if slot0.chatStickerView_ then
		slot0.chatStickerView_:Dispose()

		slot0.chatStickerView_ = nil
	end

	slot0.loopScrollView_:Dispose()

	slot0.loopScrollView_ = nil

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSend_, nil, function ()
		if uv0.inputField_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			uv0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(uv0.inputField_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.inputField_.text = ""

			return
		end

		uv0.inputField_.text, slot2 = textLimit(uv0.inputField_.text, GameSetting.chat_length_max.value[1])

		if not slot2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot0))

			return
		end

		if not nameRule(slot1, true) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(uv0.inputField_.text, function (slot0, slot1)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				if uv0.inputField_.text == "" then
					return
				end

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				ChatAction.SendFriendMsg(uv0.friendID_, uv0.inputField_.text, slot1, function (slot0)
					if isSuccess(slot0.result) then
						ChatData:SetSendTextTimestamp()

						uv0.inputField_.text = ""
					elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
						uv0.inputField_.text = ""

						JumpTools.OpenPageByJump("chatMuted")

						return
					else
						ShowTips(slot0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.CHAT_FRIEND)
	end)
	slot0:AddBtnListener(slot0.buttonSticker_, nil, function ()
		SetActive(uv0.goStickerHide_, true)
		uv0.chatStickerView_:Show(true)
		SetActive(uv0.bgGo_, true)
	end)
	slot0:AddBtnListener(slot0.buttonStickerHide_, nil, function ()
		uv0:HideStickerPanel()
		SetActive(uv0.goReportTips_, false)
	end)
	slot0:AddBtnListener(slot0.buttonNewMsg_, nil, function ()
		uv0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(uv0.friendID_)
		SetActive(uv0.goNewMsg_, false)
		ChatFriendData:SaveRecordCnt(uv0.friendID_)
		manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, uv0.friendID_)
		FriendsAction:RefreshUnread(uv0.friendID_, 0)
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		SetActive(uv0.goReportTips_, false)
		SetActive(uv0.goStickerHide_, false)
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = uv0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.buttonHead_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.friendID_)
	end)
end

function slot0.HideStickerPanel(slot0)
	SetActive(slot0.goStickerHide_, false)
	slot0.chatStickerView_:Show(false)
	SetActive(slot0.bgGo_, false)
end

function slot0.RefreshContent(slot0)
	slot0:RefreshTitle()
	slot0.loopScrollView_:Scroll2End()
end

function slot0.OnSendSticker(slot0, slot1)
	slot0:HideStickerPanel()

	if ChatData:IsMuted() then
		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_STICKER_FREQUENTLY")

		return
	end

	ChatAction.SendFriendSticker(slot0.friendID_, slot1, function (slot0)
		if isSuccess(slot0.result) then
			ChatData:SetSendStickerTimestamp()

			uv0.inputField_.text = ""
		elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
			uv0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.OnReceiveMsg(slot0, slot1)
	if slot0.friendID_ ~= slot1 then
		return
	end

	slot3 = ChatFriendData
	slot5 = slot3

	for slot5 = 0, slot3.GetUnreadMsgCnt(slot5, slot1) - 1 do
		if slot0:LsGetItemData()[#slot0:LsGetItemData() - slot5].senderID == USER_ID then
			slot0.loopScrollView_:Scroll2End()
			ChatFriendData:UpdateSeek(slot0.friendID_)

			return
		end
	end

	if not slot0.loopScrollView_:IsFillContent() or slot0.scrollView_.verticalNormalizedPosition <= 0.0001 then
		slot0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(slot0.friendID_)

		return
	end

	SetActive(slot0.goNewMsg_, true)
	slot0.loopScrollView_:RefreshScrollView()
end

function slot0.OnRecallMsg(slot0, slot1)
	if slot0.friendID_ ~= slot1 then
		return
	end

	slot0.loopScrollView_:RefreshScrollView(true)
	SetActive(slot0.goNewMsg_, ChatFriendData:GetUnreadMsgCnt(slot1) > 0)
end

function slot0.OnChatReport(slot0, slot1)
	slot0.transformReport_:SetParent(slot1.parentRect.transform, false)

	slot0.transformReport_.localPosition = Vector2(slot1.x, slot1.y)
	slot0.reportData_ = slot1.reportData

	SetActive(slot0.goReportTips_, true)
	SetActive(slot0.goStickerHide_, true)
end

function slot0.OnHideChatReport(slot0)
	SetActive(slot0.goReportTips_, false)
end

function slot0.RefreshTitle(slot0)
	slot1 = FriendsData:GetInfoByID(slot0.friendID_)

	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end

	slot0.textIp_.text = slot1.ip
	slot0.textNick_.text = slot1.nick
	slot0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot1.icon].icon)
	slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot1.icon_frame)
	slot0.textSign_.text = slot1.sign

	if slot1.online_state == 0 then
		slot0.onlineController_:SetSelectedState("on")
	else
		slot0.onlineController_:SetSelectedState("off")
	end
end

function slot0.InitItemPool(slot0)
	slot0.itemSelfPool_ = {}
	slot0.itemFriendPool_ = {}
	slot0.historyTipsPool_ = {}
end

function slot0.GetSelfFreeItem(slot0)
	for slot4, slot5 in pairs(slot0.itemSelfPool_) do
		if slot5.isFree == true then
			slot5.isFree = false

			return slot5
		end
	end

	slot2 = {
		isFree = false,
		itemView = ChatFriendContentItem.New(slot0.goSelfItem_, slot0.goItemParent_)
	}

	table.insert(slot0.itemSelfPool_, slot2)

	return slot2
end

function slot0.GetFriendFreeItem(slot0)
	for slot4, slot5 in pairs(slot0.itemFriendPool_) do
		if slot5.isFree == true then
			slot5.isFree = false

			return slot5
		end
	end

	slot2 = {
		isFree = false,
		itemView = ChatFriendContentItem.New(slot0.goFriendItem_, slot0.goItemParent_)
	}

	table.insert(slot0.itemFriendPool_, slot2)

	return slot2
end

function slot0.GetHistoryTipsFreeItem(slot0)
	for slot4, slot5 in pairs(slot0.historyTipsPool_) do
		if slot5.isFree == true then
			slot5.isFree = false

			return slot5
		end
	end

	slot2 = {
		isFree = false,
		itemView = ChatFriendHistoryTipsItem.New(slot0.goHistoryTips_, slot0.goItemParent_)
	}

	table.insert(slot0.historyTipsPool_, slot2)

	return slot2
end

function slot0.DisposeItemPool(slot0)
	for slot4, slot5 in ipairs(slot0.itemSelfPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemSelfPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemFriendPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemFriendPool_ = nil

	for slot4, slot5 in ipairs(slot0.historyTipsPool_) do
		slot5.itemView:Dispose()
	end

	slot0.historyTipsPool_ = nil
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot3 = nil

	((slot1.contentType ~= ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or slot0:GetHistoryTipsFreeItem()) and (slot1.senderID ~= tostring(PlayerData:GetPlayerInfo().userID) or slot0:GetSelfFreeItem()) and slot0:GetFriendFreeItem()).itemView:SetData(slot1, slot2)

	slot4 = ChatFriendData:GetUnreadMsgCnt(slot0.friendID_)

	if slot2 >= #slot0:LsGetItemData() then
		SetActive(slot0.goNewMsg_, false)
		ChatFriendData:SaveRecordCnt(slot0.friendID_)
		FriendsAction:RefreshUnread(slot0.friendID_, 0)
		manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, slot0.friendID_)
	elseif slot4 > #slot0:LsGetItemData() - slot2 then
		ChatFriendData:SaveRecordCnt(slot0.friendID_, slot5)
		FriendsAction:RefreshUnread(slot0.friendID_, slot5)
		manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, slot0.friendID_)
	end

	return slot3
end

function slot0.LsUpdateItem(slot0, slot1, slot2, slot3)
	slot1.itemView:SetData(slot2, slot3)
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.LsGetItemData(slot0)
	return ChatFriendData:GetCacheContent(slot0.friendID_)
end

return slot0
