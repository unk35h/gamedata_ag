slot0 = class("GuildInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubSharePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.btnTransform_, "name")
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshBtn)
	slot0.enterGuildHandler_ = handler(slot0, slot0.EnterGuild)
end

function slot0.OnEnter(slot0)
	slot0.guildID_ = slot0.params_.guildID

	slot0:RefreshUI()
	manager.notify:RegistListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, slot0.refreshHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), uv0.guildID_) then
			return
		end

		slot1 = manager.notify

		slot1:RegistListener(GUILD_ENTER, uv0.enterGuildHandler_)
		GuildAction.GuildRequestJoin(uv0.guildID_, function (slot0)
			manager.notify:RemoveListener(GUILD_ENTER, uv0.enterGuildHandler_)
		end)
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = GuildData:GetCacheGuildInfo(slot0.guildID_)
	slot2 = ClubHeadIconCfg[slot1.icon]
	slot0.icon_.sprite = getSpriteViaConfig("ClubHeadIcon", slot2.iconName)
	slot0.iconBg_.sprite = getSpriteViaConfig("ClubHeadIcon", slot2.bg)
	slot0.idText_.text = string.format("ID:%s", slot1.id)
	slot0.nameText_.text = slot1.name
	slot0.levelText_.text = slot1.level
	slot0.activePointText_.text = slot1.contribute
	slot8 = slot1.maxMemberCnt
	slot0.memberText_.text = string.format("%s/%s", slot1.memberCnt, slot8)
	slot0.captainNameText_.text = slot1.captain
	slot0.noticeText_.text = slot1.notice

	SetActive(slot0.limitLevelGo_, not slot1.isFree)

	slot0.limitLevelText_.text = slot1.limitLevel
	slot4 = slot1.exp

	for slot8 = slot1.level - 1, 1, -1 do
		slot4 = slot4 - ClubLevelCfg[slot8].club_level_exp
	end

	slot5 = ClubLevelCfg[slot3].club_level_exp

	if GameSetting.club_max_level.value[1] <= slot3 then
		slot0.expText_.text = "-/-"
		slot0.progressImage_.fillAmount = 1
	else
		slot0.expText_.text = string.format("%s/%s", slot4, slot5)
		slot0.progressImage_.fillAmount = slot4 / slot5
	end

	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	slot1 = slot0.guildID_

	if GuildData:GetGuildInfo().id then
		slot0.controller_:SetSelectedState("cannot")
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), slot1) then
		slot0.controller_:SetSelectedState("applyed")
	else
		slot0.controller_:SetSelectedState("apply")
	end
end

function slot0.EnterGuild(slot0)
	slot0:Back()
	JumpTools.OpenPageByJump("/guildEntrace/guildMain")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshHandler_ = nil
	slot0.enterGuildHandler_ = nil
end

return slot0
