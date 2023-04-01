slot0 = class("ChatSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/HomeDialogueUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.chatToggleID_ = slot0.params_.chatToggleID
	slot0.worldChatMsgContent_ = nil
	slot0.chatSeek_ = {}
	slot0.historySeek_ = {}

	slot0:AddListeners()

	slot0.bgController_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.sendController_ = ControllerUtil.GetController(slot0.transform_, "send")
	slot0.worldController_ = ControllerUtil.GetController(slot0.toggleWorld_.transform, "toggle")
	slot0.guildController_ = ControllerUtil.GetController(slot0.toggleGuild_.transform, "toggle")
	slot0.guildLockController_ = ControllerUtil.GetController(slot0.toggleGuild_.transform, "name")
	slot0.guildRecruitLockContoller_ = ControllerUtil.GetController(slot0.toggleGuildRecruit_.transform, "name")
	slot0.guildActivityController_ = ControllerUtil.GetController(slot0.toggleGuildActivity_.transform, "name")
	slot0.worldView_ = ChatWorldView.New(slot0.gameObject_)
	slot0.chatStickerView_ = ChatStickerView.New(slot0.goSticker_)

	slot0:InitItemPool()

	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.scrollView_, slot0.rectGrid_, slot0.viewPort_.rect.height, slot0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing, true)
	slot0.switchChannelHandler_ = handler(slot0, slot0.OnSwitchChannel)
	slot0.receiveHandler_ = handler(slot0, slot0.OnReceiveMessage)
	slot0.sendStickerHandler_ = handler(slot0, slot0.OnSendSticker)
	slot0.resetWorldChatHandler_ = handler(slot0, slot0.OnResetWorldChat)
	slot0.resetGuildChatHandler_ = handler(slot0, slot0.OnResetGuildChat)
	slot0.chatReportHandler_ = handler(slot0, slot0.OnChatReport)
	slot0.chatReportHideHandler_ = handler(slot0, slot0.OnHideChatReport)
	slot0.receiveGuildHandler_ = handler(slot0, slot0.OnReceiveGuildMessage)
	slot0.guildExitHandler_ = handler(slot0, slot0.RefreshGuildToggle)
	slot0.guildEnterHandler_ = handler(slot0, slot0.RefreshGuildToggle)
end

function slot0.OnEnter(slot0)
	ChatAction.EnterChatUI(1)

	if slot0.params_.ignoreBG ~= true then
		manager.ui:SetMainCamera("chat")

		slot0.noNeedCreateModel_ = false
	end

	slot0.bgController_:SetSelectedState(tostring(slot0.params_.ignoreBG == true))

	slot1 = slot0.params_.chatToggleID

	slot0:RefreshGuildActivityToggle(slot1)
	slot0:RefreshToggle(slot1)

	if slot0.params_.isBack == nil then
		slot0.historySeek_ = {}
	end

	slot0:SwitchToggle()
	slot0:RefreshGuildToggle()
	slot0:RefreshGuildRecruitToggle()
	slot0:RefreshCooperationToggle()
	slot0:RefreshPosterGirl()
	slot0.chatStickerView_:OnEnter()

	if slot0.worldView_ then
		slot0.worldView_:OnEnter()
	end

	manager.notify:RegistListener(CHAT_NEW_CHANNEL, slot0.switchChannelHandler_)
	manager.notify:RegistListener(CHAT_NEW_MESSAGE, slot0.receiveHandler_)
	manager.notify:RegistListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)
	manager.notify:RegistListener(CHAT_WORLD_RESET, slot0.resetWorldChatHandler_)
	manager.notify:RegistListener(CHAT_GUILD_RESET, slot0.resetGuildChatHandler_)
	manager.notify:RegistListener(CHAT_REPORT, slot0.chatReportHandler_)
	manager.notify:RegistListener(CHAT_REPORT_HIDE, slot0.chatReportHideHandler_)
	manager.notify:RegistListener(CHAT_GUILD_NEW_MESSAGE, slot0.receiveGuildHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.guildExitHandler_)
	manager.notify:RegistListener(GUILD_ENTER, slot0.guildEnterHandler_)
	slot0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(slot0, slot0.OnReceiveCooperationMessage))
	slot0:RegistEventListener(CHAT_COOPERATION_RESET, handler(slot0, slot0.OnResetCooperationChat))
	slot0:OnHideChatReport()
end

function slot0.OnExit(slot0)
	slot0:StopGuildRecruitTimer()
	slot0:SaveScrollPos()
	slot0:RemoveAllEventListener()
	manager.notify:RemoveListener(CHAT_NEW_CHANNEL, slot0.switchChannelHandler_)
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, slot0.receiveHandler_)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)
	manager.notify:RemoveListener(CHAT_WORLD_RESET, slot0.resetWorldChatHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_RESET, slot0.resetGuildChatHandler_)
	manager.notify:RemoveListener(CHAT_REPORT, slot0.chatReportHandler_)
	manager.notify:RemoveListener(CHAT_REPORT_HIDE, slot0.chatReportHideHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_NEW_MESSAGE, slot0.receiveGuildHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.guildExitHandler_)
	manager.notify:RemoveListener(GUILD_ENTER, slot0.guildEnterHandler_)
	slot0.chatStickerView_:OnExit()

	if slot0.worldView_ then
		slot0.worldView_:OnExit()
	end

	if slot0.params_.ignoreBG ~= true then
		manager.ui:ResetMainCamera()
	end

	if slot0.tpose_ then
		slot0.tpose_.transform.localScale = Vector3.New(1, 1, 1)

		manager.resourcePool:DestroyOrReturn(slot0.tpose_, ASSET_TYPE.TPOSE)

		slot0.tpose_ = nil
		slot0.posterGirlId_ = nil
	end
end

function slot0.OnUpdate(slot0)
	if slot0.chatToggleID_ == slot0.params_.chatToggleID then
		return
	end

	slot0:SaveScrollPos()
	slot0:SwitchToggle()
end

function slot0.Dispose(slot0)
	slot0:DisposeItemPool()

	slot0.switchChannelHandler_ = nil
	slot0.receiveHandler_ = nil
	slot0.sendStickerHandler_ = nil
	slot0.chatReportHandler_ = nil
	slot0.chatReportHideHandler_ = nil
	slot0.receiveGuildHandler_ = nil
	slot0.resetWorldChatHandler_ = nil
	slot0.resetGuildChatHandler_ = nil
	slot0.guildExitHandler_ = nil
	slot0.guildEnterHandler_ = nil

	if slot0.loopScrollView_ then
		slot0.loopScrollView_:Dispose()

		slot0.loopScrollView_ = nil
	end

	if slot0.worldView_ then
		slot0.worldView_:Dispose()

		slot0.worldView_ = nil
	end

	if slot0.chatStickerView_ then
		slot0.chatStickerView_:Dispose()

		slot0.chatStickerView_ = nil
	end

	slot0.noNeedCreateModel_ = true

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClosePanel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddToggleListener(slot0.toggleWorld_, function (slot0)
		if slot0 then
			uv0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
			})
		end
	end)
	slot0:AddToggleListener(slot0.toggleGuild_, function (slot0)
		if slot0 then
			uv0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
			})
		end
	end)
	slot0:AddToggleListener(slot0.toggleCooperation_, function (slot0)
		if slot0 then
			uv0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
			})
		end
	end)
	slot0:AddToggleListener(slot0.toggleGuildRecruit_, function (slot0)
		if slot0 then
			if PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1] then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2))
				uv0:RefreshToggle(uv0.chatToggleID_)
			else
				uv0:Go("chat", {
					chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
				})
			end
		end
	end)
	slot0:AddToggleListener(slot0.toggleGuildActivity_, function (slot0)
		if slot0 then
			if not GuildActivityData:HaveRegister() then
				ShowTips("ACTIVITY_CLUB_NOT_JOIN")
				uv0:RefreshToggle(uv0.chatToggleID_)

				return
			end

			uv0:Go("chat", {
				chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY
			})
		end
	end)
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

		slot0 = nil

		if uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
			slot0 = JUDGE_MESSAGE_TYPE.CHAT_WORLD
		elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
			slot0 = JUDGE_MESSAGE_TYPE.CHAT_GUILD
		elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
			slot0 = JUDGE_MESSAGE_TYPE.GUILD_SHARE
		elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
			slot0 = JUDGE_MESSAGE_TYPE.GUILD_ACTIVITY
		else
			print("chat toggle type is null")
		end

		uv0.inputField_.text, slot3 = textLimit(uv0.inputField_.text, GameSetting.chat_length_max.value[1])

		if not slot3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot1))

			return
		end

		if not nameRule(slot2, true) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(uv0.inputField_.text, function (slot0, slot1)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				if uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
					if uv0.inputField_.text == "" then
						return
					end

					ChatAction.SendMsg(uv0.inputField_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
					if GuildData:GetGuildInfo().id == nil then
						ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

						return
					end

					if uv0.inputField_.text == "" then
						return
					end

					ChatAction.SendGuildMsg(uv0.inputField_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
					if uv0.inputField_.text == "" then
						return
					end

					ChatAction.SendGuildRecruitMsg(uv0.inputField_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
					if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) == false then
						ShowTips("ACTIVITY_CLUB_OVER")

						return
					end

					if uv0.inputField_.text == "" then
						return
					end

					ChatAction.SendChatNormalMsg(uv0.chatToggleID_, uv0.inputField_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
					if not CooperationData:CheckInRoom() then
						ShowTips("ERROR_INVALID_OPERATION")

						return
					end

					if uv0.inputField_.text == "" then
						return
					end

					ChatAction.SendCooperationdMsg(uv0.inputField_.text, slot1, function (slot0)
						uv0:SendMessageResult(slot0)
					end)
				end
			end
		end, slot0)
	end)
	slot0:AddBtnListener(slot0.buttonSticker_, nil, function ()
		SetActive(uv0.goStickerHide_, true)
		uv0.chatStickerView_:Show(true)
		SetActive(uv0.listBgGo_, true)
	end)
	slot0:AddBtnListener(slot0.buttonStickerHide_, nil, function ()
		uv0:HideStickerPanel()
		uv0:OnHideChatReport()
	end)
	slot0:AddBtnListener(slot0.buttonNewMsg_, nil, function ()
		uv0.loopScrollView_:Scroll2End()

		if uv0.chatSeek_[uv0.chatToggleID_] == #uv0:LsGetItemData() then
			SetActive(uv0.goNewMsg_, false)

			if uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
				ChatGuildData:SaveRecordCnt()
			elseif uv0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
				ChatChannelData:SaveRecordCnt(uv0.chatToggleID_)
			end
		end
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		uv0:OnHideChatReport()
		SetActive(uv0.goStickerHide_, false)
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = uv0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
end

function slot0.RefreshToggle(slot0, slot1)
	if slot1 == ChatConst.CHAT_CHANNEL_WORLD then
		slot0.toggleWorld_.isOn = true
	elseif slot1 == ChatConst.CHAT_CHANNEL_GUILD then
		slot0.toggleGuild_.isOn = true
	elseif slot1 == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		slot0.toggleGuildRecruit_.isOn = true
	elseif slot1 == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		slot0.toggleGuildActivity_.isOn = true
	elseif slot1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0.toggleCooperation_.isOn = true
	end
end

function slot0.SwitchToggle(slot0)
	slot0.chatToggleID_ = slot0.params_.chatToggleID

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		slot0.sendController_:SetSelectedState("false")

		if GameSetting.chat_club_refresh_time.value[1] < manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() then
			ChatAction.RequireGuildShareInfo()
		end

		slot0:AddGuildRecruitTimer()
	else
		slot0.sendController_:SetSelectedState("true")
		slot0:StopGuildRecruitTimer()
	end

	slot0.loopScrollView_:SetContentHeight(slot0.viewPort_.rect.height)
	SetActive(slot0.goGuildTips_, false)
	slot0.worldController_:SetSelectedState("off")

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		slot0.worldController_:SetSelectedState("on")
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()

		if ChatGuildData:InitCacheGuildContent() ~= 0 then
			if slot1 ~= #ChatGuildData:GetCacheContent() then
				slot0.historySeek_[slot0.chatToggleID_] = {
					verticalNormalizedPosition = 1,
					index = slot1
				}
			end
		end

		if not GuildData:GetGuildInfo().id then
			SetActive(slot0.goGuildTips_, true)
			ShowTips("NEED_JOIN_CLUB")
		end
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		ChatChannelData:InitCacheContent(slot0.chatToggleID_)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if ChatCooperationData:InitCacheCooperationContent() ~= 0 then
			if slot1 ~= #ChatCooperationData:GetCacheContent() then
				slot0.historySeek_[slot0.chatToggleID_] = {
					verticalNormalizedPosition = 1,
					index = slot1
				}
			end
		end

		slot0.worldController_:SetSelectedState("off")
		SetActive(slot0.goGuildTips_, false)
	end

	if slot0.historySeek_[slot0.chatToggleID_] then
		slot0.loopScrollView_:RestoredScroll(slot0.historySeek_[slot0.chatToggleID_].index, slot0.historySeek_[slot0.chatToggleID_].verticalNormalizedPosition)
	else
		slot0.loopScrollView_:Scroll2End()
	end

	slot0.chatSeek_[slot0.chatToggleID_] = slot0.chatSeek_[slot0.chatToggleID_] or 0

	SetActive(slot0.goNewMsg_, slot0.chatSeek_[slot0.chatToggleID_] < #slot0:LsGetItemData())
end

function slot0.OnSwitchChannel(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		slot0.loopScrollView_:Scroll2End()
	end
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

function slot0.OnReceiveMessage(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		slot0:RefreshReceiveMessage()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		if #slot0.loopScrollView_:GetItemList() <= 0 then
			slot0.loopScrollView_:Scroll2End()
		else
			slot0.loopScrollView_:RefreshScrollView(true, true)
		end
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.OnReceiveGuildMessage(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.OnReceiveCooperationMessage(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0:RefreshReceiveMessage()
	end
end

function slot0.RefreshReceiveMessage(slot0)
	slot1 = slot0:LsGetItemData()[#slot0:LsGetItemData()]
	slot5 = slot0

	for slot5 = slot0.chatSeek_[slot0.chatToggleID_] + 1, #slot0.LsGetItemData(slot5) do
		if slot0:LsGetItemData()[slot5].id == USER_ID then
			slot0.loopScrollView_:Scroll2End()

			return
		end
	end

	if slot1.id == USER_ID then
		slot0.loopScrollView_:Scroll2End()

		return
	end

	if not slot0.loopScrollView_:IsFillContent() or slot0.scrollView_.verticalNormalizedPosition <= 0.01 then
		slot0.loopScrollView_:Scroll2End()

		return
	end

	SetActive(slot0.goNewMsg_, true)
end

function slot0.SendMessageResult(slot0, slot1)
	if isSuccess(slot1.result) then
		ChatData:SetSendTextTimestamp()

		slot0.inputField_.text = ""
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		slot0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnSendSticker(slot0, slot1)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY and ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) == false then
		ShowTips("ACTIVITY_CLUB_OVER")

		return
	end

	slot0:HideStickerPanel()

	if ChatData:IsMuted() then
		slot0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_STICKER_FREQUENTLY")

		return
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		ChatAction.SendSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if GuildData:GetGuildInfo().id == nil then
			ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

			return
		end

		ChatAction.SendGuildSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatAction.SendGuildRecruitSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		ChatAction.SendChatNormalSticker(slot0.chatToggleID_, slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if not CooperationData:CheckInRoom() then
			ShowTips("ERROR_INVALID_OPERATION")

			return
		end

		ChatAction.SendCooperationSticker(slot1, function (slot0)
			uv0:SendStickerResult(slot0)
		end)
	else
		ShowTips("SEND_MESSAGE_ERROR")
	end
end

function slot0.SendStickerResult(slot0, slot1)
	if isSuccess(slot1.result) then
		ChatData:SetSendStickerTimestamp()
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	elseif slot1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		slot0.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(slot1.result)
	end
end

function slot0.HideStickerPanel(slot0)
	SetActive(slot0.goStickerHide_, false)
	slot0.chatStickerView_:Show(false)
	SetActive(slot0.listBgGo_, false)
end

function slot0.OnResetWorldChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
			ChatChannelData:InitCacheContent(slot0.chatToggleID_)
		end

		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.OnResetGuildChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()
		slot0.loopScrollView_:RefreshScrollView(true)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.OnResetCooperationChat(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		slot0.loopScrollView_:RefreshScrollView(true)
	end
end

function slot0.RefreshGuildToggle(slot0)
	slot0.guildLockController_:SetSelectedState(tostring(GuildData:GetGuildInfo().id == nil))
end

function slot0.RefreshGuildRecruitToggle(slot0)
	slot0.guildRecruitLockContoller_:SetSelectedState(tostring(PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1]))
end

function slot0.RefreshGuildActivityToggle(slot0, slot1)
	SetActive(slot0.goGuildActivity_, ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) or slot1 == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY or manager.windowBar:GetWhereTag() == "guildActivity")
end

function slot0.RefreshCooperationToggle(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		SetActive(slot0.toggleCooperation_.gameObject, true)
	else
		SetActive(slot0.toggleCooperation_.gameObject, false)
	end
end

function slot0.SaveScrollPos(slot0)
	if slot0.loopScrollView_:GetItemList()[1] then
		slot0.historySeek_[slot0.chatToggleID_] = {
			index = slot1.itemView:GetIndex(),
			verticalNormalizedPosition = slot0.scrollView_.verticalNormalizedPosition
		}
	end
end

function slot0.RefreshPosterGirl(slot0)
	if HeroCfg[PlayerData:GetPlayerInfo().poster_girl] then
		if slot0.posterGirlId_ == HeroTools.HeroUsingSkinInfo(slot1).id then
			return
		end

		slot0.posterGirlId_ = slot4
		slot6 = "Char/" .. slot3.main_model_id
		slot7 = slot3.home_weapon_show and slot3.home_weapon_show ~= 0

		if slot0 and not slot0.noNeedCreateModel_ then
			if slot0.tpose_ then
				manager.resourcePool:DestroyOrReturn(slot0.tpose_, ASSET_TYPE.TPOSE)

				slot0.tpose_ = nil
			end

			slot0.tpose_ = manager.resourcePool:Get(slot6, ASSET_TYPE.TPOSE)
			slot8 = HeroPosAndRotCfg[slot2.id].position_chat
			slot9 = HeroPosAndRotCfg[slot2.id].rotation_main
			slot10 = HeroPosAndRotCfg[slot2.id].scale_main
			slot11 = Screen.safeArea
			slot13 = GameSetting.chat_model_rotation.value
			slot0.tpose_.transform.localPosition = Vector3.New(slot8[1], slot8[2], slot8[3]) + Vector3(-1.24 * slot11.width / slot11.height / 1.7777777777777777, 0, 0)
			slot0.tpose_.transform.localEulerAngles = Vector3.New(slot9[1] + slot13[1], slot9[2] * -1 + slot13[2], slot9[3] + slot13[3])
			slot0.tpose_.transform.localScale = Vector3.New(slot10[1], slot10[2], slot10[3])

			if slot0:FindTrs(slot4 .. "ui", slot0.tpose_.transform) then
				slot14.localEulerAngles = Vector3.zero
			end

			if slot0:FindTrs(string.format("%dui/%dui_tpose", slot4, slot4), slot0.tpose_.transform) then
				slot16 = slot0:FindCom(typeof(Animator), "", slot15)
				slot0.animator_ = slot16

				if slot16 then
					LuaForUtil.EnableEyeController(slot15.transform, true)
					manager.resourcePool:ResetBlendShapes(slot15.transform)
					slot16:Play("action1_1")
				end

				HeroTools.SetHeroModelWeaponActivity(slot15, slot7)
			end
		end
	end
end

function slot0.AddGuildRecruitTimer(slot0)
	slot0:StopGuildRecruitTimer()

	slot0.guildRecruitTimer_ = Timer.New(function ()
		if GameSetting.chat_club_refresh_time.value[1] < manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() then
			ChatAction.RequireGuildShareInfo()
		end
	end, 1, -1)

	slot0.guildRecruitTimer_:Start()
end

function slot0.StopGuildRecruitTimer(slot0)
	if slot0.guildRecruitTimer_ then
		slot0.guildRecruitTimer_:Stop()

		slot0.guildRecruitTimer_ = nil
	end
end

function slot0.LsGetItemData(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		return ChatData:GetWorldChatData()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		return ChatGuildData:GetCacheContent()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		return ChatGuildRecruitData:GetChatData()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		return ChatChannelData:GetCacheContent(slot0.chatToggleID_)
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		return ChatCooperationData:GetCacheContent()
	else
		return {}
	end
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot3 = nil

	((slot1.contentType ~= ChatConst.CHAT_CONTENT_TYPE.CHANNEL or slot0:GetFreeItem(slot0.itemChannelPool_, function ()
		return ChatChannelView.New(uv0.goChannelTitle_, uv0.goItemParent_)
	end)) and (slot1.contentType ~= ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP or slot0:GetFreeItem(slot0.itemTimePool_, function ()
		return ChatTimeView.New(uv0.goTimeStamp_, uv0.goItemParent_)
	end)) and (slot1.contentType ~= ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or slot0:GetFreeItem(slot0.historyTipsPool_, function ()
		return ChatFriendHistoryTipsItem.New(uv0.goHistoryTips_, uv0.goItemParent_)
	end)) and (slot1.contentType ~= ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT or (slot1.id ~= tostring(PlayerData:GetPlayerInfo().userID) or slot0:GetFreeItem(slot0.itemSelfGuildRecruitPool_, function ()
		return ChatGuildRecruitItemView.New(uv0.goSelfGuildRecruitItem_, uv0.goItemParent_)
	end)) and slot0:GetFreeItem(slot0.itemFriendGuildRecruitPool_, function ()
		return ChatGuildRecruitItemView.New(uv0.goFriendGuildRecruitItem_, uv0.goItemParent_)
	end)) and (slot1.id ~= tostring(PlayerData:GetPlayerInfo().userID) or slot0:GetFreeItem(slot0.itemSelfPool_, function ()
		return ChatItemView.New(uv0.goSelfItem_, uv0.goItemParent_, uv0.scrollView_)
	end)) and slot0:GetFreeItem(slot0.itemFriendPool_, function ()
		return ChatItemView.New(uv0.goFriendItem_, uv0.goItemParent_, uv0.scrollView_)
	end)).itemView:SetData(slot1, slot2)

	slot0.chatSeek_[slot0.chatToggleID_] = slot0.chatSeek_[slot0.chatToggleID_] or 0

	if slot0.chatSeek_[slot0.chatToggleID_] < slot2 then
		slot0.chatSeek_[slot0.chatToggleID_] = slot2
	end

	if slot2 >= #slot0:LsGetItemData() then
		SetActive(slot0.goNewMsg_, false)
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:SaveRecordCnt()
	elseif slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		ChatChannelData:SaveRecordCnt(slot0.chatToggleID_)
	end

	return slot3
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.InitItemPool(slot0)
	slot0.itemChannelPool_ = {}
	slot0.itemTimePool_ = {}
	slot0.itemSelfPool_ = {}
	slot0.itemFriendPool_ = {}
	slot0.itemSelfGuildRecruitPool_ = {}
	slot0.itemFriendGuildRecruitPool_ = {}
	slot0.historyTipsPool_ = {}
end

function slot0.GetFreeItem(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.isFree == true then
			slot7.isFree = false

			return slot7
		end
	end

	slot3 = {
		isFree = false,
		itemView = slot2()
	}

	table.insert(slot1, slot3)

	return slot3
end

function slot0.DisposeItemPool(slot0)
	for slot4, slot5 in ipairs(slot0.itemChannelPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemChannelPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemTimePool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemTimePool_ = nil

	for slot4, slot5 in ipairs(slot0.itemSelfPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemSelfPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemFriendPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemFriendPool_ = nil

	for slot4, slot5 in ipairs(slot0.itemSelfGuildRecruitPool_) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.itemFriendGuildRecruitPool_) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.historyTipsPool_) do
		slot5.itemView:Dispose()
	end
end

return slot0
