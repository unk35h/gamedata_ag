slot1 = class("BattleResultBaseView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.UIName(slot0)
	return "UI/BattleResult/BattleResultSlayerUI"
end

function slot1.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshCommonUI()
	slot0:RefreshSummerUI()
	slot0:RefreshBattleTime()
end

function slot1.RefreshSummerUI(slot0)
	slot3 = SlayerData:GetOldGetPoint(slot0.stageData:GetActivityID(), slot0.stageData:GetDest())
	slot4 = 0
	slot5 = {}
	slot6 = 0

	if LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas then
		for slot12, slot13 in ipairs(ActivitySlayerSkillPointCfg.all) do
			slot14 = ActivitySlayerSkillPointCfg[slot13]

			if slot7:TryGetValue(slot13, nil) then
				slot17 = slot7[slot16]
				slot4 = slot4 + slot14.point * slot17
				slot6 = slot6 + slot17

				if not slot5[slot14.tyep] then
					slot5[slot14.tyep] = 0
				end

				slot5[slot14.tyep] = slot5[slot14.tyep] + slot17
			end
		end
	end

	slot0.m_slayerCur.text = slot4

	if slot3 < slot4 then
		SetActive(slot0.m_slayerNew, true)

		slot0.m_slayerMax.text = slot4
	else
		SetActive(slot0.m_slayerNew, false)

		slot0.m_slayerMax.text = slot3
	end

	slot0.m_slayerRecord1.text = slot5[1] or 0
	slot0.m_slayerRecord2.text = slot5[2] or 0
	slot0.m_slayerRecord3.text = slot5[3] or 0
	slot0.m_slayerRecordAll.text = slot6
end

return slot1
