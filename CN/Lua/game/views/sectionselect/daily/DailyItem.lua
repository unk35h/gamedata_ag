slot1 = class("DailyItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("dailySectionInfo")
end

function slot1.InitCustom(slot0)
	SetActive(slot0.collectGo_, false)
end

function slot1.GetPosition(slot0)
	return BattleDailyStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot1.RefreshData(slot0)
	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isLock_ = false
		slot0.clearTimes_ = slot1.clear_times
		slot0.starCnt_ = 3
	else
		slot0.isLock_ = true
		slot0.clearTimes_ = 0
		slot0.starCnt_ = 0
	end

	slot0.enoughLevel_ = BattleDailyStageCfg[slot0.stageID_].level <= PlayerData:GetPlayerInfo().userLevel
end

function slot1.OnClick(slot0)
	if not slot0.isLock_ then
		BattleFieldData:SetStageByClientID(slot0.chapterID_, slot0.stageID_)
		slot0:Go("dailySectionInfo", {
			section = slot0.stageID_
		})
	end
end

function slot1.RefreshText(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY, slot0.stageID_)
	slot0.text_.text = string.format("%s-%s", GetI18NText(slot1), slot2)
end

return slot1
