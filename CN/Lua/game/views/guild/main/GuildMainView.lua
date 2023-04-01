slot0 = class("GuildMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubHomeUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chatTextExtension_ = slot0.textChat_:GetComponent(typeof(TextExtension))
	slot0.switchHeadIconHandler_ = handler(slot0, slot0.SwitchHeadIcon)
	slot0.renameHandler_ = handler(slot0, slot0.GuildRename)
	slot0.refreshNoticeHandler_ = handler(slot0, slot0.RefreshGuildNotice)
	slot0.switchIconServerHandler_ = handler(slot0, slot0.GuildSwitchIconServer)
	slot0.newMessageHandler_ = handler(slot0, slot0.NewMessage)
	slot0.refreshMemberHandler_ = handler(slot0, slot0.RefreshMember)
	slot0.shareHandler_ = handler(slot0, slot0.RefreshShareBtn)
	slot0.resetGuildChatHandler_ = handler(slot0, slot0.RefreshMessage)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.statusController_ = ControllerUtil.GetController(slot0.bossBtn_.transform, "status")
end

function slot0.OnEnter(slot0)
	if GuildData:GetGuildInfo().id == nil then
		return
	end

	CommunityAction:RefreshCurrencyA()
	slot0:RefreshGuildUI()
	manager.notify:RegistListener(GUILD_SWITCH_HEAD_ICON, slot0.switchHeadIconHandler_)
	manager.notify:RegistListener(GUILD_RENAME, slot0.renameHandler_)
	manager.notify:RegistListener(GUILD_NOTICE, slot0.refreshNoticeHandler_)
	manager.notify:RegistListener(GUILD_SWITCH_ICON_SERVER, slot0.switchIconServerHandler_)
	manager.notify:RegistListener(CHAT_GUILD_NEW_MESSAGE, slot0.newMessageHandler_)
	manager.notify:RegistListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
	manager.notify:RegistListener(GUILD_SHARE, slot0.shareHandler_)
	manager.notify:RegistListener(CHAT_GUILD_RESET, slot0.resetGuildChatHandler_)

	if slot1.post == GuildConst.GUILD_POST.CAPTAIN and slot1.impeachTime - manager.time:GetServerTime() > 0 and not GuildData:GetImpeachFlag() then
		JumpTools.OpenPageByJump("guildImpeachTips")
	end

	manager.redPoint:bindUIandKey(slot0.transformManager_, RedPointConst.GUILD_MANAGER)
	manager.redPoint:bindUIandKey(slot0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:bindUIandKey(slot0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:bindUIandKey(slot0.noticeContainer_, RedPointConst.GUILD_BOSS, {
		x = 0,
		y = 0
	})
	slot0:AddGuildBossTimer()
end

function slot0.OnTop(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0:Go("/home")

		return
	end

	slot0:RefreshWindowBar()
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(2)
	end)
	slot0:CheckCooperationInviteEntry()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(GUILD_SWITCH_HEAD_ICON, slot0.switchHeadIconHandler_)
	manager.notify:RemoveListener(GUILD_RENAME, slot0.renameHandler_)
	manager.notify:RemoveListener(GUILD_NOTICE, slot0.refreshNoticeHandler_)
	manager.notify:RemoveListener(GUILD_SWITCH_ICON_SERVER, slot0.switchIconServerHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_NEW_MESSAGE, slot0.newMessageHandler_)
	manager.notify:RemoveListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
	manager.notify:RemoveListener(GUILD_SHARE, slot0.shareHandler_)
	manager.notify:RemoveListener(CHAT_GUILD_RESET, slot0.resetGuildChatHandler_)
	manager.redPoint:unbindUIandKey(slot0.transformManager_, RedPointConst.GUILD_MANAGER)
	manager.redPoint:unbindUIandKey(slot0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:unbindUIandKey(slot0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:unbindUIandKey(slot0.noticeContainer_, RedPointConst.GUILD_BOSS)
	slot0:StopTimer()
	slot0:StopGuildBossTimer()
	slot0:StopShareTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.resetGuildChatHandler_ = nil
	slot0.switchHeadIconHandler_ = nil
	slot0.renameHandler_ = nil
	slot0.refreshNoticeHandler_ = nil
	slot0.switchIconServerHandler_ = nil
	slot0.newMessageHandler_ = nil
	slot0.refreshMemberHandler_ = nil
	slot0.shareHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnCopy_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = GuildData:GetGuildInfo().id

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.buttonName_, nil, function ()
		JumpTools.OpenPageByJump("guildRename")
	end)
	slot0:AddBtnListener(slot0.buttonNotice_, nil, function ()
		JumpTools.OpenPageByJump("guildChangeNotice")
	end)
	slot0:AddBtnListener(slot0.buttonLogo_, nil, function ()
		if GuildConst.GUILD_POST.DEPUTY <= GuildData:GetGuildInfo().post then
			return
		end

		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = slot0.icon
		})
	end)
	slot0:AddBtnListener(slot0.buttonManager_, nil, function ()
		GuildAction.RequiredGuildMemberList(function (slot0)
			uv0:Go("/guildManager")
		end)
	end)
	slot0:AddBtnListener(slot0.buttonMember_, nil, function ()
		GuildAction.RequiredGuildMemberList(function (slot0)
			uv0:Go("/guildMemberList")
		end)
	end)
	slot0:AddBtnListener(slot0.buttonShop_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 21
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.buttonTask_, nil, function ()
		JumpTools.OpenPageByJump("/communityTask")
	end)
	slot0:AddBtnListener(slot0.buttonWelfare_, nil, function ()
		JumpTools.OpenPageByJump("communityWelfare")
	end)
	slot0:AddBtnListener(slot0.buttonChat_, nil, function ()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.btnLevel_, nil, function ()
		uv0.textLimitExp_.text = string.format("%s/%s", GuildData:GetGuildInfo().curWeekExp, GuildData:GetMaxWeekExp())

		uv0:AddTimer()
	end)
	slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
		if not GuildData:GetBossData().initedFromServer then
			ShowTips("GUILD_BOSS_CD_TIP")

			return
		end

		JumpTools.OpenPageByJump("/guildBossMain", {
			isEnter = 1
		}, ViewConst.SYSTEM_ID.GUILD_BOSS)
	end)
	slot0:AddBtnListener(slot0.guildShareBtn_, nil, function ()
		if manager.time:GetServerTime() < GuildData:GetShareTimestamp() then
			ShowTips(string.format(GetTips("CLUB_SHARE_CD_TIPS"), manager.time:GetLostTimeStr(slot0)))
		else
			JumpTools.OpenPageByJump("guildShareInfo")
		end
	end)
	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
end

function slot0.RefreshWindowBar(slot0)
	slot1 = {}
	slot2 = GameSetting.club_info_describe.value

	manager.windowBar:SwitchBar((GuildData:GetGuildInfo().post > GuildConst.GUILD_POST.DEPUTY or (#slot2 <= 0 or {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and (#slot2 <= 0 or {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) and {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})

	if #slot2 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				pages = slot2
			}
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshGuildUI(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0.textName_.text = slot1.name

	slot0:GuildSwitchIconServer(slot1.icon)

	slot0.textID_.text = string.format("ID:%s", slot1.id)
	slot0.textCaptain_.text = slot1.captain
	slot3 = slot1.exp

	for slot7 = slot1.level - 1, 1, -1 do
		slot3 = slot3 - ClubLevelCfg[slot7].club_level_exp
	end

	slot4 = ClubLevelCfg[slot2].club_level_exp

	if GameSetting.club_max_level.value[1] <= slot2 then
		slot0.textExp_.text = "-/-"
		slot0.imageProcess_.fillAmount = 1
	else
		slot0.textExp_.text = string.format("%s/%s", slot3, slot4)
		slot0.imageProcess_.fillAmount = slot3 / slot4
	end

	slot0.textLevel_.text = slot2
	slot0.textNotice_.text = slot1.notice

	TimeTools.StartAfterSeconds(0.1, function ()
		uv0:UpdateGuildBossTimer()
	end, {})
	slot0:RefreshMember()
	slot0:RefreshMessage()
end

function slot0.RefreshMessage(slot0)
	ChatGuildData:InitCacheGuildContent()
	slot0:NewMessage()
end

function slot0.UpdateGuildBossTimer(slot0)
	slot1, slot2 = GuildData:GetLastTime()

	if slot1 == "prepose" then
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		slot0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)
		slot0.bossBtnImage_.sprite = getSprite("Atlas/ClubUI", "Boss_btn_002")
	else
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		slot0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)
		slot0.bossBtnImage_.sprite = getSprite("Atlas/ClubUI", "Boss_btn_001")
	end
end

function slot0.SwitchHeadIcon(slot0, slot1)
	GuildAction.GuildSwitchIcon(slot1, function (slot0)
		if isSuccess(slot0.result) then
			ShowTips("CLUB_CHANGED_ICON_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.GuildRename(slot0, slot1)
	slot0.textName_.text = slot1
end

function slot0.RefreshGuildNotice(slot0, slot1)
	slot0.textNotice_.text = slot1
end

function slot0.GuildSwitchIconServer(slot0, slot1)
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot1].icon_bg)
end

function slot0.NewMessage(slot0)
	slot2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)
	slot3, slot4 = nil

	if #ChatGuildData:GetCacheContent() > 0 then
		for slot8 = #slot1, 1, -1 do
			if slot1[slot8].id and not table.keyof(slot2, slot3.id) then
				if slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
					slot4 = string.format("[%s]", ChatStickerCfg[tonumber(slot3.content)].name)

					break
				end

				slot4 = slot3.content

				break
			end
		end

		if slot3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot4 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot3.content)].name))
		end

		slot0.chatTextExtension_:SetText(string.format("%s:%s", slot3.nick, slot4))
	else
		slot0.textChat_.text = ""
	end
end

function slot0.RefreshMember(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0.textMember_.text = string.format("%s/%s", slot1.memberCnt, ClubLevelCfg[slot1.level].user_num_max)

	slot0:RefreshWindowBar()

	if slot1.post == GuildConst.GUILD_POST.CAPTAIN then
		slot0.controller_:SetSelectedState("0")
	elseif slot1.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("2")
	end

	slot0:RefreshShareBtn()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	SetActive(slot0.goLevelTips_, true)

	slot0.timer_ = Timer.New(function ()
		uv0:StopTimer()
	end, 3, 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	SetActive(slot0.goLevelTips_, false)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddGuildBossTimer(slot0)
	if slot0.guildBossTimer_ == nil then
		slot0.guildBossTimer_ = Timer.New(function ()
			uv0:UpdateGuildBossTimer()
		end, 1, -1)
	end

	slot0.guildBossTimer_:Start()
end

function slot0.StopGuildBossTimer(slot0)
	if slot0.guildBossTimer_ then
		slot0.guildBossTimer_:Stop()

		slot0.guildBossTimer_ = nil
	end
end

function slot0.AddShareTimer(slot0)
	slot0:StopShareTimer()

	slot1 = GuildData:GetGuildInfo()

	if GuildData:GetShareTimestamp() < manager.time:GetServerTime() then
		slot0:RefreshShareBtn()

		return
	end

	slot3 = manager.time:GetServerTime() - slot2
	slot0.timeText_.text = manager.time:GetLostTimeStr(slot2)
	slot0.shareTimer_ = Timer.New(function ()
		uv1.timeText_.text = manager.time:GetLostTimeStr(uv0)

		if manager.time:GetServerTime() - uv0 >= 0 then
			uv1:StopShareTimer()
			uv1:RefreshShareBtn()

			return
		end
	end, 1, -1)

	slot0.shareTimer_:Start()
end

function slot0.StopShareTimer(slot0)
	if slot0.shareTimer_ then
		slot0.shareTimer_:Stop()

		slot0.shareTimer_ = nil
	end
end

function slot0.RefreshShareBtn(slot0)
	if table.keyof(GameSetting.club_share_member_list.value, GuildData:GetGuildInfo().post) then
		SetActive(slot0.guildShareGo_, true)
	else
		SetActive(slot0.guildShareGo_, false)

		return
	end

	if GuildData:GetShareTimestamp() <= manager.time:GetServerTime() then
		SetActive(slot0.timeGo_, false)
	else
		SetActive(slot0.timeGo_, true)
		slot0:AddShareTimer()
	end
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
