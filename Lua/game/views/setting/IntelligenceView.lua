slot0 = class("IntelligenceView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.missions_ = {}

	for slot4 = 1, 3 do
		slot0.missions_[slot4] = {
			go = slot0[string.format("mission%dGo_", slot4)],
			on = slot0[string.format("mission%dOnGo_", slot4)],
			off = slot0[string.format("mission%dOffGo_", slot4)],
			name = slot0[string.format("mission%dNameText_", slot4)],
			progress = slot0[string.format("mission%dNumText_", slot4)],
			progressGo = slot0[string.format("mission%dNumText_", slot4)].gameObject
		}
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.UpdateAllMission(slot0, slot1)
	slot2 = slot1

	for slot6 = 1, 3 do
		if slot2 and slot2[slot6] then
			slot7 = ThreeStarConditionCfg[slot2[slot6].id]
			slot0.missions_[slot6].name.text = BattleInstance.GetStarMissionText(slot2[slot6].id, slot2[slot6].xData, slot2[slot6].yData)
			slot9 = false

			if BattleStageData:GetStageData()[slot0.info_.section] and slot8.stars and slot8.stars[slot6] == 1 then
				slot9 = true
			end

			SetActive(slot0.missions_[slot6].on, slot2[slot6].isComplete or slot9)
			SetActive(slot0.missions_[slot6].off, not slot2[slot6].isComplete and not slot9)

			if slot9 then
				slot0.missions_[slot6].progress.text = "-/-"
			else
				slot0.missions_[slot6].progress.text = string.format("%d/%d", slot2[slot6].current, slot2[slot6].total)
			end

			SetActive(slot0.missions_[slot6].go, true)
		else
			SetActive(slot0.missions_[slot6].go, false)
		end
	end
end

function slot0.SetLevelTitle(slot0, slot1)
	slot4, slot5 = BattleStageTools.GetChapterSectionIndex(slot1:GetType(), slot1:GetStageId())

	if slot4 ~= "" then
		slot0.titleText_.text = string.format("%s-%s", slot4, slot5)
	else
		slot0.titleText_.text = ""
	end

	slot0.nameText_.text = BattleStageTools.GetStageName(slot3, slot2)
end

function slot0.RefreshUI(slot0)
	slot0:SetLevelTitle(slot0.info_.stageData)
	slot0:UpdateAllMission(slot0.info_.starMissionData)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.info_ = nil
	slot0.hander_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
