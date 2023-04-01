slot0 = class("ChipManagerUnlockView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.handler_ = handler(slot0, slot0.RefreshBtn)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, slot0.handler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.schemeBtn_, nil, function ()
		uv0:OnSchemeBtn()
	end)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		uv0:OnClickUseBtn()
	end)

	slot4 = slot0.unloadBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		uv0:OnClickUnloadBtn()
	end)

	for slot4 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		slot0:AddBtnListener(slot0[string.format("chipBtn%s_", slot4)], nil, function ()
			uv0:OnSelectChipBtn(uv1)
		end)
	end
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
	slot2 = ChipCfg[slot1]

	for slot7 = 1, #slot0:GetChipData() do
		SetActive(slot0[string.format("chipIconGo%s_", slot7)], true)

		slot0[string.format("chipIcon%s_", slot7)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot3[slot7]].picture_id)
	end

	for slot7 = #slot3 + 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		SetActive(slot0[string.format("chipIconGo%s_", slot7)], false)
	end

	slot0:RefreshBtn()
	slot0:BindRedPoint()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.useBtnGo_, slot0:GetEnabledManagerID() ~= slot0.chipManagerID_)
	SetActive(slot0.unloadBtnGo_, slot1 == slot0.chipManagerID_)
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil
end

function slot0.GetChipData(slot0)
	return ChipData:GetChipManagerList()[slot0.chipManagerID_]
end

function slot0.GetEnabledManagerID(slot0)
	return ChipData:GetEnabledChipManagerID()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.chipBtnTransform_, RedPointConst.CHIP_CHIP)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.chipBtnTransform_)
end

function slot0.OnSchemeBtn(slot0)
	JumpTools.OpenPageByJump("chipScheme", {
		chipManagerID = slot0.chipManagerID_
	})
end

function slot0.OnClickUseBtn(slot0)
	ChipAction.EnabledChipManagerID(slot0.chipManagerID_)
end

function slot0.OnClickUnloadBtn(slot0)
	ChipAction.EnabledChipManagerID(0)
end

function slot0.OnSelectChipBtn(slot0, slot1)
	slot0:Go("/chipInfo", {
		chipManagerID = slot0.chipManagerID_,
		selectChipIndex = slot1
	})
end

return slot0
