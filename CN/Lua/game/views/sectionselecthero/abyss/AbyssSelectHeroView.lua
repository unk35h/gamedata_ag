slot0 = class("AbyssSelectHeroView", SectionSelectHeroBaseView)

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/abyssTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_,
		layerId = slot0.params_.layerId
	})
end

function slot0.ChangeHeroTeam(slot0, slot1)
	if slot1[1] ~= slot0.cacheHeroTeam_[1] then
		slot0:PlayHeroTalk(slot2[1])
	end

	AbyssData:SetHeroTeam(slot0.stageID_, slot1)
end

function slot0.GetSelectHero(slot0)
	slot0.heroTrialList_ = {
		0,
		0,
		0
	}

	if slot0.params_.isReserves then
		slot0.cacheHeroTeam_ = BattleTeamData:GetReservesTeam(slot0.params_.index)
	else
		slot0.cacheHeroTeam_ = AbyssData:GetCanUseCachedHero(slot0.stageID_, slot0.params_.layerId)
	end

	slot0.lockStateList_ = {
		false,
		false,
		false
	}
	slot0.lockList_ = {}

	if false or slot0.params_.isReserves then
		slot0:ChangeHeroTeam(slot0.cacheHeroTeam_)
		ComboSkillData:SetNeedRefresh(true)
	end
end

function slot0.StartBattle(slot0)
	if AbyssCfg[slot0.params_.layerId].stage_list[slot0.params_.stageIndex][1] == 3 then
		AbyssData:SetCurrentBossPhase(AbyssData:GetStageData(slot0.params_.layerId, slot0.params_.stageIndex).phase or 1)
	end

	slot2 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, slot0.params_.activityID)

	slot2:SetMultiple(slot0.multiple_)
	slot2:SetStageData(slot0.params_.layerId, slot0.params_.stageIndex)
	BattleController.GetInstance():LaunchBattle(slot2)
end

function slot0.GotoReservesUI(slot0)
	slot5 = slot0.comboSkillView_

	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = slot0.stageType_,
		activityID = slot0.params_.activityID,
		hero_list = slot0.cacheHeroTeam_,
		hero_trial_list = slot0.heroTrialList_,
		lockList = slot0:GetLockList(),
		comboSkill = slot5:GetCurComboSkill(),
		chipInfo = {
			enabledID = slot0.chipView_:GetCurEnabledID(),
			chipList = slot0.chipView_:GetCurChipList()
		}
	})
end

function slot0.GetLockList(slot0)
	slot1 = {}

	table.insertto(slot1, AbyssData:GetLockedHeroList(slot0.params_.layerId))
	table.insertto(slot1, AbyssData:GetAbandonHeroList())

	return slot1
end

return slot0
