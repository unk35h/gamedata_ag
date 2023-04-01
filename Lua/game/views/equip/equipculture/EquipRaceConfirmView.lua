slot0 = class("EquipRaceConfirmView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipRaceConfirmUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.labController = ControllerUtil.GetController(slot0.m_labController, "item0")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBaseRace_, nil, function ()
		uv0:OnRaceConfirmClick(false)
	end)
	slot0:AddBtnListener(slot0.btnPreRace_, nil, function ()
		uv0:OnRaceConfirmClick(true)
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId

	if not EquipData:GetEquipData(slot0.equipId) then
		return
	end

	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Equip/Portrait/" .. ItemCfg[slot1.prefab_id].icon)

	if slot1.race ~= 0 and RaceEffectCfg[slot2] then
		slot0.textRace_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot3.name))
		slot0.raceImage_.sprite = getSprite("Atlas/CampItem", slot3.icon)

		SetActive(slot0.raceImage_.gameObject, true)
		slot0.labController:SetSelectedIndex(1)
	else
		slot0.textRace_.text = GetTips("EQUIP_NO_RACE")
		slot0.raceImage_.sprite = nil

		SetActive(slot0.raceImage_.gameObject, false)
		slot0.labController:SetSelectedIndex(0)
	end

	if slot1.race_preview ~= 0 and RaceEffectCfg[slot4] then
		slot0.textRacePre_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot5.name))
		slot0.raceImagePre_.sprite = getSprite("Atlas/CampItem", slot5.icon)

		SetActive(slot0.raceImagePre_.gameObject, true)
	else
		slot0.textRacePre_.text = GetTips("EQUIP_NO_RACE")
		slot0.raceImagePre_.sprite = nil

		SetActive(slot0.raceImagePre_.gameObject, false)
	end
end

function slot0.OnRaceConfirmClick(slot0, slot1)
	EquipAction.QueryEquipRaceConfirm(slot0.equipId, slot1)
end

function slot0.OnEquipRaceConfirm(slot0)
	slot0:Back()
end

return slot0
