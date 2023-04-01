slot0 = class("ChallengeSectionInfoView", import("..SectionInfoMultipleBaseView"))

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHero", {
		section = slot0.stageID_,
		multiple = slot0.multiple_
	})
end

function slot0.RefreshData(slot0)
	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < StageCfg[slot0.stageID_].level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)
	slot0.cost = slot1.cost
	slot0.drop_lib_id = slot1.drop_lib_id
	slot0.isFirstClear_ = BattleStageData:GetStageData()[slot0.stageID_].clear_times <= 0

	uv0.super.RefreshData(slot0)
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= StageCfg[slot0.stageID_].id then
		slot2, slot3 = getChapterAndSectionID(slot1.id)
		slot0.sectionText_.text = string.format("%s-%s", GetI18NText(ChapterCfg[slot2].english), slot3)
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.tipsText_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end
end

return slot0
