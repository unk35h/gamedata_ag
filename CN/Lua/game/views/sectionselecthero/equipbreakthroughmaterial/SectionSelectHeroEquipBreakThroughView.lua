slot0 = class("SectionSelectHeroEquipBreakThroughView", SectionSelectHeroBaseView)

function slot0.GetComboSkillView(slot0)
	return SectionComboSkillEquipBreakThroughView
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.updateHandler_ = handler(slot0, slot0.UpdateBreakThroughData)

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)

	slot0.updateHandler_ = nil
end

function slot0.OnTop(slot0)
	uv0.super.OnTop(slot0)
	EquipBreakThroughMaterialAction.CheckTimeout()
end

function slot0.RefreshAddBtn(slot0)
	uv0.super.RefreshAddBtn(slot0)

	for slot4 = 1, 3 do
		SetActive(slot0["hp" .. slot4 .. "Go_"], false)
	end

	slot0:RefreshEquipBTMaterialHP()
end

function slot0.RefreshEquipBTMaterialHP(slot0)
	slot2 = {}

	if #EquipBreakThroughMaterialData:GetHeroState() > 0 then
		for slot6, slot7 in pairs(slot1) do
			slot2[slot6] = {
				heroID = slot7.heroID,
				rate = slot7.rate
			}
		end
	else
		slot5 = EquipBreakThroughMaterialData
		slot7 = slot5

		for slot6, slot7 in pairs(slot5.GetCacheHero(slot7)) do
			slot2[slot6] = {
				rate = 10000,
				heroID = slot7
			}
		end
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7.heroID ~= 0 then
			slot0.hpImg_[slot6].fillAmount = slot7.rate / 10000
			slot8 = math.ceil(slot7.rate / 100)

			if slot7.rate > 0 and slot8 < 1 then
				slot8 = 1
			end

			slot0.hpText_[slot6].text = slot8 .. "%"

			if slot7.rate ~= 0 then
				SetActive(slot0["hp" .. slot6 .. "Go_"], true)
			end
		end
	end
end

function slot0.UpdateBreakThroughData(slot0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function slot0.GetSkinCfg(slot0, slot1, slot2)
	return slot0:GetHeroCfg(slot2)
end

function slot0.GetHeroCfg(slot0, slot1)
	return HeroTools.HeroUsingSkinInfo(slot1)
end

function slot0.GoHeroInfoUI(slot0, slot1)
	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and (slot2[slot1][1] == 0 or slot3[1] ~= 0 and HeroCfg[slot3[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot3[1])) then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	if slot0.cacheHeroTeam_[slot1] == 0 and slot0.lockStateList_[slot1] == true then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	slot0:Go("/heroTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_
	})
end

function slot0.RefreshReservesBtn(slot0)
	SetActive(slot0.reservesBtn_.gameObject, false)
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = slot1
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot3[slot7] = slot0.heroTrialList_[table.keyof(slot0.cacheHeroTeam_, slot8)]
	end

	if slot2[1] ~= slot0.cacheHeroTeam_[1] then
		slot0:PlayHeroTalk(slot2[1])
	end

	EquipBreakThroughMaterialData:SetHeroTeam(slot2)
end

function slot0.StartBattle(slot0)
	if EquipBreakThroughMaterialData:GetComboSkillID() == -1 then
		slot1 = ComboSkillData

		EquipBreakThroughMaterialAction.SaveComboSkillID(slot1:GetComboSkillID(slot0.stageType_, slot0.activityID_, 1), function ()
			uv0.super.StartBattle(uv1)
		end)
	else
		uv0.super.StartBattle(slot0)
	end
end

function slot0.GetChipView(slot0)
	return SectionChipEquipBreakThroughView
end

return slot0
