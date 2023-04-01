slot0 = class("ChatGuildInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.btnTransform_, "name")

	slot0:AddListeners()

	slot0.refreshHandler_ = handler(slot0, slot0.RefreshBtn)
	slot0.enterGuildHandler_ = handler(slot0, slot0.EnterGuild)

	manager.notify:RegistListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.guildBtn_, nil, function ()
		JumpTools.OpenPageByJump("guildInfo", {
			guildID = uv0.guildID_
		})
	end)
	slot0:AddBtnListener(slot0.button_, nil, function ()
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

function slot0.SetGuildID(slot0, slot1)
	slot0.guildID_ = slot1
	slot2 = GuildData:GetCacheGuildInfo(slot1)
	slot0.nameText_.text = slot2.name
	slot0.iconBg_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot2.icon].icon_bg)
	slot0.levelText_.text = slot2.level
	slot0.idText_.text = string.format("ID:%s", slot2.id)
	slot0.memberText_.text = string.format("%s/%s", slot2.memberCnt, slot2.maxMemberCnt)

	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	if slot0.gameObject_.activeSelf == false then
		return
	end

	slot1 = slot0.guildID_

	if GuildData:GetGuildInfo().id then
		if slot2.id == slot1 then
			slot0.controller_:SetSelectedState("joined")

			slot0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_1"))
		else
			slot0.controller_:SetSelectedState("cannot")

			slot0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_2"))
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), slot1) then
		slot0.controller_:SetSelectedState("applyed")

		slot0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_4"))
	else
		slot0.controller_:SetSelectedState("apply")

		slot0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_3"))
	end
end

function slot0.EnterGuild(slot0)
	if manager.windowBar:GetWhereTag() == nil then
		JumpTools.OpenPageByJump("/guildEntrace/guildMain")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, slot0.refreshHandler_)

	slot0.refreshHandler_ = nil
	slot0.enterGuildHandler_ = nil
end

return slot0
