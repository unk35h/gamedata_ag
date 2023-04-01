slot0 = class("SectionSelectHeroChip", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListener()
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isCustom_ then
			ShowTips("CANNOT_CHANGE_CHIP")
		else
			ChipAction:UpdateChipRed()
			uv0:Go("/battleChipManager", {
				stageType = uv0.stageType_,
				activityID = uv0.activityID_,
				cont_id = uv0.cont_id_,
				team_id = uv0.team_id_
			})
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.activityID_ = slot3
	slot0.cont_id_ = slot4
	slot0.team_id_ = slot5
	slot0.isCustom_ = false

	if BattleStageTools.GetStageCfg(slot1, slot2) and type(slot6.chip_list) == "table" then
		slot0.enabledID_ = slot6.chip_list[1]
		slot0.chipList_ = {}

		for slot10 = 2, 3 do
			slot0.chipList_[slot10 - 1] = slot6.chip_list[slot10]
		end

		slot0:RefreshUI()

		slot0.isCustom_ = true

		return
	end

	slot0.enabledID_ = slot0:GetChipManagerID()
	slot0.chipList_ = slot0:GetChipList()

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = (slot0.enabledID_ or 0) == 0

	SetActive(slot0.chipManagerGo_, not slot2)

	if slot2 then
		for slot6 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
			SetActive(slot0[string.format("chipIconGo%s_", slot6)], false)
		end
	else
		if ChipCfg[slot1] == nil then
			print(string.format("ChipCfg[%s] is nil", slot1))
		end

		slot0.chipManagerImg_.sprite = getSpriteViaConfig("ChipIcon", ChipCfg[slot1].picture_id)
		slot3 = slot0.chipList_

		if GameSetting.ai_secondary_chip_equip_num.value[1] < #slot0.chipList_ then
			for slot8 = #slot0.chipList_, slot4 + 1, -1 do
				slot0.chipList_[slot8] = nil
			end
		end

		for slot8, slot9 in ipairs(slot3) do
			if slot9 == nil or slot9 == 0 then
				break
			end

			SetActive(slot0[string.format("chipIconGo%s_", slot8)], true)

			if ChipCfg[slot9] == nil then
				print(string.format("ChipCfg[%s] is nil", slot9))
			end

			slot0[string.format("chipIcon%s_", slot8)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot9].picture_id)
		end

		for slot8 = #slot3 + 1, slot4 do
			SetActive(slot0[string.format("chipIconGo%s_", slot8)], false)
		end
	end
end

function slot0.GetChipManagerID(slot0)
	return BattleTeamData:GetMimirIDInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
end

function slot0.GetChipList(slot0)
	return BattleTeamData:GetMimirChipInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
end

function slot0.GetCurEnabledID(slot0)
	return slot0.enabledID_ or 0
end

function slot0.GetCurChipList(slot0)
	return slot0.chipList_ or {}
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
