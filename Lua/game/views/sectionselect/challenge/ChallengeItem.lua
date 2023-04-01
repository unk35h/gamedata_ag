slot1 = class("ChallengeItem", import("game.views.sectionSelect.SectionBaseItem"))

function slot1.InitCustom(slot0)
	SetActive(slot0.collectGo_, false)
end

function slot1.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("challengeSectionInfo")
end

function slot1.RefreshData(slot0)
	if BattleStageData:GetStageData()[slot0.stageID_] then
		slot0.isLock_ = false
		slot0.clearTimes_ = slot1.clear_times
		slot2 = 0

		for slot6, slot7 in ipairs(slot1.stars) do
			if slot7 > 0 then
				slot2 = slot2 + 1
			end
		end

		slot0.starCnt_ = slot2
	else
		slot0.isLock_ = true
		slot0.clearTimes_ = -1
		slot0.starCnt_ = 0
	end

	slot0.enoughLevel_ = StageCfg[slot0.stageID_].level <= PlayerData:GetPlayerInfo().userLevel
end

function slot1.OnClick(slot0)
	if not slot0.isLock_ then
		slot0:Go("challengeSectionInfo", {
			section = slot0.stageID_
		})
	end
end

return slot1
