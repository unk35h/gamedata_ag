slot0 = class("SectionSelectHeroSequentialBattleView", SectionSelectHeroBaseView)

function slot0.GetComboSkillView(slot0)
	return SectionComboSkillSequentialBattleView
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.btnText_.text = GetTips("SAVE_TEAM")
	slot0.buffController_ = ControllerUtil.GetController(slot0.transform_, "buff")

	slot0.buffController_:SetSelectedState("true")

	slot0.buffView_ = SectionSelectHeroBuffView.New(slot0.buffPanel_)
end

function slot0.OnEnter(slot0)
	slot0.chipView_:SetParams(slot0.params_.activityID, slot0.params_.section)
	uv0.super.OnEnter(slot0)
	manager.windowBar:RegistHomeCallBack(function ()
		if #uv0.loadingList_ > 0 then
			return
		end

		if SequentialBattleData:IsSameTeamData(uv0.params_.activityID, table.keyof(SequentialBattleChapterCfg[uv0.params_.activityID].stage_id, uv0.stageID_)) then
			SequentialBattleData:RevertChapterData(uv0.params_.activityID)
			uv0:Go("/home")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_SAVE_TEAM"),
			OkCallback = function ()
				SequentialBattleData:RevertChapterData(uv0.params_.activityID)
				uv0:Go("/home")
			end,
			CancelCallback = function ()
			end
		})
	end)
	manager.windowBar:RegistBackCallBack(function ()
		if #uv0.loadingList_ > 0 then
			return
		end

		if SequentialBattleData:IsSameTeamData(uv0.params_.activityID, table.keyof(SequentialBattleChapterCfg[uv0.params_.activityID].stage_id, uv0.stageID_)) then
			SequentialBattleData:RevertChapterData(uv0.params_.activityID)
			uv0:Back()

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_SAVE_TEAM"),
			OkCallback = function ()
				SequentialBattleData:RevertChapterData(uv0.params_.activityID)
				uv0:Back()
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0.buffView_:OnEnter(slot0.params_.activityID, slot0.params_.section)
end

function slot0.OnExit(slot0)
	slot0.buffView_:OnExit()
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.buffView_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshText(slot0)
	slot0.stageName_.text = GetTips(string.format("TEAM_%s", table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.stageID_)))
end

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/heroTeamInfoSequentialBattle", {
		isEnter = true,
		selectHeroPos = slot1,
		activityID = slot0.params_.activityID,
		stageID = slot0.stageID_,
		stageType = slot0.stageType_
	})
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = slot1
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot3[slot7] = slot0.heroTrialList_[table.keyof(slot0.cacheHeroTeam_, slot8)]
	end

	if slot2[1] ~= slot0.cacheHeroTeam_[1] then
		slot0:PlayHeroTalk(slot2[1])
	end

	SequentialBattleData:SaveHeroTeam(slot0.params_.activityID, table.keyof(SequentialBattleChapterCfg[slot0.params_.activityID].stage_id, slot0.stageID_), slot2, slot3)
end

function slot0.OnClickStartBattle(slot0)
	if #slot0.loadingList_ > 0 then
		return
	end

	slot0:StartBattle()
end

function slot0.StartBattle(slot0)
	for slot6, slot7 in pairs(SequentialBattleData:GetHeroTeamData(slot0.params_.activityID)) do
		if slot7.needRefreshComboSkill then
			slot8 = {}

			for slot12, slot13 in ipairs(slot7.heroList) do
				table.insert(slot8, slot13.heroID)
			end

			SequentialBattleData:SetComboSkillID(slot1, slot6, ComboSkillTools.GetRecommendSkillID(slot8, true), false)
		end
	end

	SequentialBattleData:SaveLocalAllTeam(slot1)
	slot0:Back()
end

function slot0.GotoReservesUI(slot0)
	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		hero_list = slot0.cacheHeroTeam_,
		lastParams = slot0.params_,
		lockList = {}
	})
end

function slot0.GetChipView(slot0)
	return SectionChipSequentialBattleView
end

return slot0
