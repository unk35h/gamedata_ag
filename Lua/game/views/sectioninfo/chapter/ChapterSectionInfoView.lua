slot0 = class("ChapterSectionInfoView", import("..SectionInfoTargetBaseView"))

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.drop_lib_id = BattleChapterStageCfg[slot0.stageID_].drop_lib_id

	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isFirstClear_ = slot2.clear_times <= 0
	else
		slot0.isFirstClear_ = true
	end

	if slot0.isFirstClear_ then
		slot0.cost = slot1.cost or 0
	else
		slot0.cost = 0
	end

	slot0:RefreshLock()
end

function slot0.RefreshLock(slot0)
	slot1 = BattleChapterStageCfg[slot0.stageID_]
	slot2 = getChapterAndSectionID(slot0.stageID_)

	BattleFieldData:SetCacheStage(slot2, slot0.stageID_)

	if ActivityData:GetActivityIsOpen(ChapterCfg[slot2].activity_id) then
		slot0.lock_ = false
	else
		slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < slot1.level
		slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)

		if slot0.lock_ then
			return
		end
	end

	slot3 = BattleStageData:GetStageData()
	slot4 = pairs
	slot6 = slot1.pre_unlock_id_list or {}

	for slot7, slot8 in slot4(slot6) do
		if slot3[slot8] == nil or slot3[slot8] and slot3[slot8].clear_times <= 0 then
			slot0.lock_ = true
			slot11, slot12 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot8).toggle, slot8)
			slot0.lockTips_ = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot8), slot11, slot12)

			return
		end
	end

	slot0.lock_ = false
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleChapterStageCfg[slot0.stageID_].id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(slot2), slot3)
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.OnClickBtn(slot0)
	if BattleConst.BATTLE_TAG.STORY == BattleChapterStageCfg[slot0.stageID_].tag then
		BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0.stageID_, 0)
	else
		slot0:Go("/sectionSelectHero", {
			section = slot0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
		})
	end
end

function slot0.GetThreeStar(slot0, slot1)
	return BattleStageData:GetStageData()[slot0.stageID_] and slot3.stars[slot1] == 1 or false, BattleChapterStageCfg[slot0.stageID_].three_star_need[slot1]
end

return slot0
