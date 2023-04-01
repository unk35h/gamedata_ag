slot1 = class("GuildActivityTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.energyItem_ = GuildActivityTeamInfoEnergyItemView.New(Object.Instantiate(Asset.Load("UI/GuildActivityUI/items/energy"), slot0.extensionContainer_))
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	slot3 = slot0.heroDataList_[slot1].id
	slot5, slot6, slot7 = slot0:IsInTeam(slot3, slot0.heroDataList_[slot1].trialID)

	slot2:SetInTeamFlag(slot5, slot6)
	slot2:SetEnergy(true, GuildActivityData:GetHeroFatigue(slot3))
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot3) ~= nil or table.keyof(slot0.lockHeroList_, slot4) ~= nil)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	SetActive(slot0.infoBtn_.gameObject, false)
end

function slot1.GetFilterClass(slot0)
	return GuildActivityFilterView
end

function slot1.GetHeroList(slot0)
	slot1 = {}
	slot2 = HeroData:GetHeroList()
	slot5 = GuildActivityData
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.GetFightHeroList(slot7)) do
		if slot2[slot7.id] then
			slot1[slot7.id] = slot2[slot7.id]
		end
	end

	return HeroTools.Sort(slot1)
end

function slot1.UpdateHeroView(slot0)
	uv0.super.UpdateHeroView(slot0)
	slot0.energyItem_:SetCurrent(true)
	slot0.energyItem_:SetData(GameSetting.activity_club_hero_fatigue_max.value[1], GuildActivityData:GetHeroFatigue(slot0.selectID_))
end

function slot1.Dispose(slot0)
	if slot0.energyItem_ then
		slot0.energyItem_:Dispose()

		slot0.energyItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot1.GetHeroTeam(slot0)
	slot5 = slot0.params_.activityID
	slot0.heroTeam_, slot0.lockStateList_, slot0.lockHeroList_, slot4 = GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot5)
	slot0.heroTrialList_ = slot4

	for slot4, slot5 in ipairs(slot0.heroTeam_) do
		slot6 = false
		slot9 = GuildActivityData
		slot11 = slot9

		for slot10, slot11 in ipairs(slot9.GetFightHeroList(slot11)) do
			if slot11.id == slot5 then
				slot6 = true

				break
			end
		end

		if not slot6 then
			slot0.heroTeam_[slot4] = 0
		end
	end

	for slot4 = 1, 2 do
		for slot8 = slot4 + 1, 3 do
			if slot0.heroTeam_[slot4] == 0 then
				slot0.heroTeam_[slot8] = slot0.heroTeam_[slot4]
				slot0.heroTeam_[slot4] = slot0.heroTeam_[slot8]
			end
		end
	end
end

return slot1
