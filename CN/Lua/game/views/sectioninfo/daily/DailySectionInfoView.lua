slot0 = class("DailySectionInfoView", import("..SectionInfoMultipleBaseView"))

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		multiple = slot0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY
	})
end

function slot0.RefreshData(slot0)
	slot1 = BattleDailyStageCfg[slot0.stageID_]
	slot0.cost = slot1.cost
	slot0.drop_lib_id = slot1.drop_lib_id

	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isFirstClear_ = slot2.clear_times <= 0
	else
		slot0.isFirstClear_ = true
	end

	slot0:RefreshLock()
	uv0.super.RefreshData(slot0)
end

function slot0.RefreshLock(slot0)
	BattleFieldData:SetCacheStage(getChapterAndSectionID(slot0.stageID_), slot0.stageID_)

	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[slot0.stageID_].level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)

	if slot0.lock_ then
		return
	end

	slot3 = BattleStageData:GetStageData()
	slot4 = pairs
	slot6 = slot1.pre_unlock_id_list or {}

	for slot7, slot8 in slot4(slot6) do
		if slot3[slot8] == nil or slot3[slot8] and slot3[slot8].clear_times <= 0 then
			slot0.lock_ = true
			slot9, slot10 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, slot8)
			slot0.lockTips_ = string.format(GetTips("ACTIVITY_RACE_UNLOCK"), string.format("%s-%s", slot9, slot10))

			return
		end
	end

	slot0.lock_ = false
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleDailyStageCfg[slot0.stageID_].id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(slot2), slot3)
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.tipsText_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end
end

return slot0
