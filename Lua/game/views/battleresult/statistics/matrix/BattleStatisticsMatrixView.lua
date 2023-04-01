slot1 = class("BattleStatisticsMatrixView", import("..BattleStatisticsView"))

function slot1.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot1 = slot0.stageData:GetHeroTeam()
	slot0.statisticsHeroItem_ = {}
	slot2, slot3, slot4 = BattleTools.GetBattleStatisticsData()
	slot5 = 1

	for slot9 = 1, 3 do
		slot10 = nil

		if slot1[slot9] and slot1[slot9] ~= 0 then
			slot10 = {
				level = 1,
				id = slot1[slot9],
				skin_id = MatrixData:GetHeroSkin(slot1[slot9])
			}
		end

		slot0.statisticsHeroItem_[slot9] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot9], slot10, slot3, slot4, slot2[slot5])
		slot5 = slot5 + 1
	end

	slot0:SetLevelTitle()
	slot0:RefreshTimeText()
end

function slot1.GetStatisticsItem(slot0)
	return BattleStatisticsMatrixHeroItem
end

function slot1.SetLevelTitle(slot0, slot1)
	slot2 = slot0.stageData:GetStageId()
	slot0.lvText_.text = ""
	slot0.stareText_.text = ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
end

return slot1
