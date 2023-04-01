slot0 = class("ChipManagerUnlockEquipBreakThroughView", import("..ChipManagerUnlockView"))

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
	SetActive(slot0.goScheme_, false)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)

	slot4 = slot0.unloadBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		ShowTips("CANNOT_CHANGE")
	end)

	for slot4 = 1, GameSetting.ai_secondary_chip_equip_num.value[1] do
		slot0:AddBtnListener(slot0[string.format("chipBtn%s_", slot4)], nil, function ()
			uv0:Go("/chipEquipBreakThroughInfo", {
				chipManagerID = uv0.chipManagerID_,
				selectChipIndex = uv1
			})
		end)
	end
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.unloadBtnGo_, false)
	SetActive(slot0.useBtnGo_, false)
end

function slot0.GetChipData(slot0)
	return EquipBreakThroughMaterialData:GetChipList()
end

function slot0.GetEnabledManagerID(slot0)
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnbindRedPoint(slot0)
end

return slot0
