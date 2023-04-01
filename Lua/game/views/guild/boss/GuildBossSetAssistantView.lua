slot1 = class("GuildBossSetAssistantView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot1 = slot0.filterView_

	slot1:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		if (slot0.id == GuildData:GetCurrentBossAssistantHeroId() and 1 or 0) ~= (slot1.id == slot4 and 1 or 0) then
			return true, slot6 < slot5
		end

		return false, false
	end)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	if GuildData:GetCurrentBossAssistantHeroId() == slot0.heroDataList_[slot1].id then
		slot2:SetTeamMarkBg("purple")
		slot2:SetTeamMark(true, GetTips("CURRENT_ASSISTANT"))
	else
		slot2:SetTeamMark(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot2.teamMarkTransform_)
end

function slot1.UpdateHeroView(slot0)
	slot2 = slot0.selectID_
	slot0.fightPowerText_.text = getHeroPower(slot2, false)

	slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.selectID_).id)

	slot3 = HeroCfg[slot2]
	slot0.nameText_.text = slot3.name
	slot0.subNameText_.text = slot3.suffix
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_ASSISTANT_HERO_CHANGE, function (slot0)
		uv0.heroHeadList_:Refresh()
		uv0:RefreshJoinBtn()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot1.GetHeroTeam(slot0)
end

function slot1.OnJoinClick(slot0)
	if GuildData:GetCurrentBossAssistantHeroId() == slot0.selectID_ then
		return
	end

	GuildAction.SetAssistHero(GuildData:GetGuildInfo().id, slot1)
end

function slot1.GetTextAndImage(slot0)
	if slot0.selectID_ == GuildData:GetCurrentBossAssistantHeroId() then
		return string.format("<color=#222222>%s</color>", GetTips("CURRENT_ASSISTANT")), "0", true
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_ASSISTANT_ROLE")), "0", true
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return slot1 == GuildData:GetCurrentBossAssistantHeroId(), false, -1
end

function slot1.GetDefaultHeroData(slot0)
	return GuildData:GetCurrentBossAssistantHeroId() > 0 and GuildData:GetCurrentBossAssistantHeroId() or slot0.heroDataList_[1].id, 0
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	CustomLog.Log(debug.traceback(string.format("heroes = %s", tostring(slot1))))
end

return slot1
