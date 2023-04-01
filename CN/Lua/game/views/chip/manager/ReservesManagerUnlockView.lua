slot0 = class("ReservesManagerUnlockView", ChipManagerUnlockView)

function slot0.SetReservesIndex(slot0, slot1)
	slot0.index_ = slot1
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
	slot0.reservesData_ = BattleTeamData:GetReservesTempTeamList()[slot0.index_]
	slot2 = slot0.reservesData_.chipInfo.list

	for slot6 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		if slot2[slot6] and slot2[slot6] ~= 0 then
			slot0[string.format("chipIcon%s_", slot6)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot2[slot6]].picture_id)

			SetActive(slot0[string.format("chipIconGo%s_", slot6)], true)
		else
			SetActive(slot0[string.format("chipIconGo%s_", slot6)], false)
		end
	end

	slot0:RefreshBtn()
	slot0:BindRedPoint()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.useBtnGo_, slot0.reservesData_.chipInfo.id ~= slot0.chipManagerID_)
	SetActive(slot0.unloadBtnGo_, slot0.reservesData_.chipInfo.id == slot0.chipManagerID_)
end

function slot0.OnSchemeBtn(slot0)
	slot0:Go("/reservesChipScheme", {
		chipManagerID = slot0.chipManagerID_,
		index = slot0.index_
	})
end

function slot0.OnClickUseBtn(slot0)
	BattleTeamData:SetReservesTempTeamChip(slot0.index_, slot0.chipManagerID_)
	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.OnClickUnloadBtn(slot0)
	BattleTeamData:SetReservesTempTeamChip(slot0.index_, 0)
	manager.notify:Invoke(ENABLED_CHIP_MANAGER)
end

function slot0.OnSelectChipBtn(slot0, slot1)
	slot0:Go("/reservesChipInfo", {
		chipManagerID = slot0.chipManagerID_,
		selectChipIndex = slot1,
		index = slot0.index_
	})
end

return slot0
