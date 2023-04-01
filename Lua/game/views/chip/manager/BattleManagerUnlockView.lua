slot1 = class("BattleManagerUnlockView", import("game.views.chip.manager.ChipManagerUnlockView"))

function slot1.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
	slot2, slot3 = slot0:GetChipData()

	for slot7 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if slot3[slot7] and slot3[slot7] ~= 0 then
			slot0[string.format("chipIcon%s_", slot7)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot3[slot7]].picture_id)

			SetActive(slot0[string.format("chipIconGo%s_", slot7)], true)
		else
			SetActive(slot0[string.format("chipIconGo%s_", slot7)], false)
		end
	end

	slot0:RefreshBtn()
	slot0:BindRedPoint()
end

function slot1.RefreshBtn(slot0)
	SetActive(slot0.useBtnGo_, slot0:GetChipData() ~= slot0.chipManagerID_)
	SetActive(slot0.unloadBtnGo_, slot1 == slot0.chipManagerID_)
end

function slot1.OnSchemeBtn(slot0)
	slot0:Go("/battleChipScheme", {
		chipManagerID = slot0.chipManagerID_,
		stageType = slot0.stageType_,
		activityID = slot0.activityID_,
		cont_id = slot0.cont_id_,
		team_id = slot0.team_id_
	})
end

function slot1.SetTeamInfo(slot0, slot1, slot2, slot3, slot4)
	slot0.stageType_ = slot1
	slot0.activityID_ = slot2
	slot0.cont_id_ = slot3
	slot0.team_id_ = slot4
end

function slot1.OnClickUseBtn(slot0)
	if slot0.enableIDFunc_ then
		slot0.enableIDFunc_(slot0.chipManagerID_)
	end

	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot1.OnClickUnloadBtn(slot0)
	if slot0.enableIDFunc_ then
		slot0.enableIDFunc_(0)
	end

	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot1.RegistEnableIDFunc(slot0, slot1)
	slot0.enableIDFunc_ = slot1
end

function slot1.OnSelectChipBtn(slot0, slot1)
	slot0:Go("/battleChipInfo", {
		chipManagerID = slot0.chipManagerID_,
		selectChipIndex = slot1,
		stageType = slot0.stageType_,
		activityID = slot0.activityID_,
		cont_id = slot0.cont_id_,
		team_id = slot0.team_id_
	})
end

function slot1.GetChipData(slot0)
	slot1, slot2 = BattleTeamData:GetMimirInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)

	return slot1, slot2
end

return slot1
