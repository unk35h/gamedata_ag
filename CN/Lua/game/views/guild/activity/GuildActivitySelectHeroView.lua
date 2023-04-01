GuildActivitySectionSelectHeroBaseView = import("game.views.sectionSelectHero.SectionSelectHeroBaseView")
slot0 = class("GuildActivitySelectHeroView", GuildActivitySectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	slot0.activityClubCfg_ = ActivityClubCfg[slot0.params_.nodeId]

	SetActive(slot0.totalEnergyPanelGo_, true)
	uv0.super.OnEnter(slot0)
	SetActive(slot0.reservesBtnGo_, false)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		slot1 = nil

		gameContext:Go("/guildActivityWarField", {
			level = (GuildActivityData:GetCurrentGrid() == nil or slot0 <= 0 or table.indexof(ActivityClubMapCfg.all, ActivityClubCfg[slot0].map_id)) and 1,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})

		if GuildActivityData:GetSelfNodeData(uv0.params_.nodeId) and slot2.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(uv0.params_.nodeId)
		end
	end)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		JumpTools.Back()

		if GuildActivityData:GetSelfNodeData(uv0.params_.nodeId) and slot0.processing_type ~= 3 then
			GuildActivityAction.UnlockNode(uv0.params_.nodeId)
		end
	end)
end

function slot0.GetSelectHero(slot0)
	slot1 = nil
	slot0.cacheHeroTeam_, slot0.lockStateList_, slot0.lockList_, slot5, slot6 = GetLocalHeroTeam(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot0.params_.isReserves, slot0.params_.index)
	slot1 = slot6
	slot0.heroTrialList_ = slot5

	for slot5, slot6 in ipairs(slot0.cacheHeroTeam_) do
		slot7 = false
		slot10 = GuildActivityData
		slot12 = slot10

		for slot11, slot12 in ipairs(slot10.GetFightHeroList(slot12)) do
			if slot12.id == slot6 then
				slot7 = true

				break
			end
		end

		if not slot7 then
			slot0.cacheHeroTeam_[slot5] = 0
			slot1 = true
		end
	end

	for slot5 = 1, 2 do
		for slot9 = slot5 + 1, 3 do
			if slot0.cacheHeroTeam_[slot5] == 0 then
				slot0.cacheHeroTeam_[slot9] = slot0.cacheHeroTeam_[slot5]
				slot0.cacheHeroTeam_[slot5] = slot0.cacheHeroTeam_[slot9]
			end
		end
	end

	if slot1 or slot0.params_.isReserves then
		slot0:ChangeHeroTeam(slot0.cacheHeroTeam_)
		ComboSkillData:SetNeedRefresh(true)
	end

	slot0.params_.isReserves = nil
end

function slot0.StartBattle(slot0)
	slot1 = slot0.activityClubCfg_.vitality_cost
	slot2 = 0

	for slot6, slot7 in pairs(slot0.cacheHeroTeam_) do
		if slot7 and slot7 > 0 then
			slot2 = slot2 + 1
		end
	end

	slot3 = math.floor(slot1 / slot2)

	if not slot0:IsLastBossDefeated() then
		for slot7, slot8 in pairs(slot0.cacheHeroTeam_) do
			if slot8 and slot8 > 0 then
				slot9 = GuildActivityData:GetFightHeroById(slot8)

				if GuildActivityData:GetHeroFatigue(slot8) < slot3 then
					ShowTips("ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP")

					return
				end
			end
		end
	end

	slot4 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, slot0.params_.activityID)

	slot4:SetMultiple(slot0.multiple_)
	slot4:SetNodeId(slot0.activityClubCfg_.id)
	slot4:SetPathList(slot0.params_.pathList)
	BattleController.GetInstance():LaunchBattle(slot4)
end

function slot0.RefreshHeroTeam(slot0)
	uv0.super.RefreshHeroTeam(slot0)
	slot0:RefreshEnergy()
end

function slot0.RefreshEnergy(slot0)
	slot0.totalEnergyText_.text = slot0.activityClubCfg_.vitality_cost

	if slot0:IsLastBossDefeated() then
		for slot5, slot6 in pairs(slot0.cacheHeroTeam_) do
			SetActive(slot0.energyGo_[slot5], false)
		end

		SetActive(slot0.totalEnergyPanelGo_, false)

		return
	end

	SetActive(slot0.totalEnergyPanelGo_, true)

	slot2 = 0

	for slot6, slot7 in pairs(slot0.cacheHeroTeam_) do
		if slot7 and slot7 > 0 then
			slot2 = slot2 + 1
		end
	end

	slot3 = math.floor(slot1 / slot2)

	for slot7, slot8 in pairs(slot0.cacheHeroTeam_) do
		if slot8 and slot8 == 0 then
			SetActive(slot0.energyGo_[slot7], false)
		else
			SetActive(slot0.energyGo_[slot7], true)

			slot0.energyText_[slot7].text = string.format("%d(-%d)", GuildActivityData:GetHeroFatigue(slot8), slot3)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0["energyBgTransform" .. slot7 .. "_"])
		end
	end
end

function slot0.IsLastBossDefeated(slot0)
	slot1 = GuildActivityData:GetNodeData(slot0.activityClubCfg_.id)

	if slot0.activityClubCfg_.id == ActivityClubCfg.all[#ActivityClubCfg.all] and slot1.health <= 0 then
		return true
	end

	return false
end

function slot0.GoHeroInfoUI(slot0, slot1)
	if #GuildActivityData:GetFightHeroList() <= 0 then
		ShowTips("ACTIVITY_CLUB_NO_FIGHT_HERO_TIP")

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and slot2[slot1][1] ~= 0 and HeroCfg[slot3[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot3[1]) then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	slot0:Go("/guildActivityTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_
	})
end

return slot0
