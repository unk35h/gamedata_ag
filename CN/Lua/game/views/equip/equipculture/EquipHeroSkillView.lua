slot0 = class("EquipHeroSkillView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipExclusiveSkillUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costItem_ = {}
	slot0.costItemGo_ = {}
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, EquipHeroSkillItem)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.list_[slot1]

	slot2:RefreshUI(slot0.equipID_, slot3)
	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelect(slot0.curSelectID_ == slot3)
	slot2:RegistCallBack(function ()
		uv0.curSelectID_ = uv1
		uv0.params_.skillID = uv0.curSelectID_

		uv0.scrollHelper_:Refresh()
		uv0:RefreshInfo()
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if not checkGold(uv0.cost_) then
			return
		end

		slot0 = {}

		for slot4 = 2, #uv0.costInfo_ do
			table.insert(slot0, uv0.costInfo_[slot4])
		end

		if not checkMaterial(slot0) then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = uv0.desc_.text .. "\n" .. GetTips("EQUIP_SKILL_UNLOCK"),
			OkCallback = function ()
				EquipAction.UpHeroEquipSkill(uv0.equipID_, uv0.curSelectID_, uv0.costInfo_)
			end
		})
	end)
	slot0:AddBtnListener(slot0.strengthBtn_, nil, function ()
		if not checkGold(uv0.cost_) then
			return
		end

		slot0 = {}

		for slot4 = 2, #uv0.costInfo_ do
			table.insert(slot0, uv0.costInfo_[slot4])
		end

		if not checkMaterial(slot0) then
			return
		end

		EquipAction.UpHeroEquipSkill(uv0.equipID_, uv0.curSelectID_, uv0.costInfo_)
	end)
	slot0:AddBtnListener(slot0.loadBtn_, nil, function ()
		slot1 = 0
		slot2 = EquipTools.CountEquipLevel(uv0.equipData_)

		for slot6, slot7 in ipairs(EquipCfg[uv0.equipData_.prefab_id].hero_slot_open_level) do
			if slot7 <= slot2 then
				slot1 = slot1 + 1
			end
		end

		if slot1 <= #uv0.useList_ then
			ShowTips("EQUIP_HERO_SKILL_MAX")

			return
		end

		table.insert(uv0.useList_, uv0.curSelectID_)
		uv0.scrollHelper_:Refresh()
		uv0:RefreshInfo()
		ShowTips("EQUIP_HERO_SKILL_LOAD")
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		table.remove(uv0.useList_, table.indexof(uv0.useList_, uv0.curSelectID_))
		uv0.scrollHelper_:Refresh()
		uv0:RefreshInfo()
		ShowTips("EQUIP_HERO_SKILL_UNLOAD")
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipID_ = slot0.params_.equipID
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)

	slot0:RefreshList()
	slot0:RefreshInfo()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.RefreshList(slot0)
	slot0.equipSkill_ = slot0.equipData_.useList or {}
	slot0.useList_ = {}

	for slot4, slot5 in ipairs(slot0.equipSkill_) do
		table.insert(slot0.useList_, slot5)
	end

	slot0.list_ = HeroCfg[slot0.equipData_.race].hero_equip_skill[EquipCfg[slot0.equipData_.prefab_id].pos] or {}

	table.sort(slot0.list_, function (slot0, slot1)
		if uv0:IsUsed(slot0) ~= uv0:IsUsed(slot1) then
			return uv0:IsUsed(slot0) ~= false
		end

		if EquipData:GetEquipSkillLv(uv0.equipID_, slot0) ~= EquipData:GetEquipSkillLv(uv0.equipID_, slot1) then
			return slot3 < slot2
		end

		return slot0 < slot1
	end)

	slot0.curSelectID_ = slot0.params_.skillID and slot0.params_.skillID ~= 0 and slot0.params_.skillID or slot0.list_[1]

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.IsUsed(slot0, slot1)
	return table.indexof(slot0.useList_, slot1) ~= false
end

function slot0.RefreshInfo(slot0)
	if not slot0.curSelectID_ then
		return
	end

	slot0.strengthBtn_.interactable = EquipData:GetEquipSkillLv(slot0.equipID_, slot0.curSelectID_) < EquipSkillCfg[slot0.curSelectID_].lvmax
	slot0.name_.text = slot1.name
	slot0.level_.text = GetTips("LEVEL") .. (slot2 >= 1 and slot2 or 1)

	slot0:RefreshSkillDesc()

	slot0.icon_.sprite = getEquipSkillSprite(slot0.curSelectID_)

	if slot2 < slot1.lvmax then
		SetActive(slot0.materialPanel_, true)

		slot0.costInfo_ = EquipMaterialCfg[GameSetting.equip_hero_skill_strengthen_cost.value[slot2 + 1]].item_list

		if not checkGold(slot0.costInfo_[1][2], false) then
			slot0.costNum_.text = "<color=#FF0000>" .. slot4[2] .. "</color>"
		else
			slot0.costNum_.text = slot4[2]
		end

		slot0.cost_ = slot4[2]

		for slot8 = 2, #slot0.costInfo_ do
			slot11 = {
				id = slot0.costInfo_[slot8][1]
			}

			if not slot0.costItem_[slot8 - 1] then
				slot0.costItemGo_[slot8 - 1] = Object.Instantiate(slot0.commonItemGo_, slot0.costPanel_)
				slot0.costItem_[slot8 - 1] = CommonItem.New(slot0.costItemGo_[slot8 - 1])
			end

			SetActive(slot0.costItemGo_[slot8 - 1], true)

			slot12 = slot0.costItem_[slot8 - 1]

			slot12:RefreshData(slot11)

			slot12 = slot0.costItem_[slot8 - 1]

			slot12:RegistCallBack(function ()
				ShowPopItem(POP_SOURCE_ITEM, {
					uv0.id
				})
			end)

			if slot9[2] <= ItemTools.getItemNum(slot10) then
				slot0.costItem_[slot8 - 1]:SetBottomText(NumberTools.RetractNumberForWindBar(slot13) .. "/" .. slot12)

				if slot10 == CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id then
					slot0.cost_ = slot12
				end
			else
				slot0.costItem_[slot8 - 1]:SetBottomText(string.format("<color=#F43950>%s</color>", slot13) .. "/" .. slot12)

				if slot10 == CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id then
					slot0.cost_ = slot12
				end
			end

			for slot17 = #slot0.costInfo_, #slot0.costItemGo_ do
				SetActive(slot0.costItemGo_[slot17], false)
			end
		end
	else
		SetActive(slot0.materialPanel_, false)
	end

	if slot2 <= 0 then
		slot0.stateCon_:SetSelectedState("unlock")
	elseif slot0:IsUsed(slot0.curSelectID_) then
		slot0.stateCon_:SetSelectedState("unload")
	else
		slot0.stateCon_:SetSelectedState("load")
	end
end

function slot0.RefreshSkillDesc(slot0)
	slot1 = slot0.curSelectID_
	slot2 = EquipSkillCfg[slot0.curSelectID_]
	slot3 = EquipData:GetEquipSkillLv(slot0.equipID_, slot0.curSelectID_)
	slot5 = HeroCfg[slot0.equipData_.race]
	slot6 = slot5.name .. "·" .. slot5.suffix
	slot7 = ""
	slot8 = GameSetting.equip_hero_skill_cd_type.value
	slot9 = GameSetting.equip_hero_skill_levelup_type.value
	slot10 = GameSetting.equip_hero_skill_damage_type.value

	if not false then
		for slot15, slot16 in ipairs(slot8) do
			if slot1 == slot16[1] then
				slot11 = slot16[2]
			end
		end
	end

	if not slot11 then
		for slot15, slot16 in ipairs(slot9) do
			if slot1 == slot16[1] then
				slot11 = slot16[2]
			end
		end
	end

	if not slot11 then
		for slot15, slot16 in ipairs(slot10) do
			if slot1 == slot16[1] then
				slot11 = slot16[2]
			end
		end
	end

	if slot11 then
		slot7 = HeroSkillCfg[slot5.skills[slot11]].name
	end

	slot12 = ""
	slot0.desc_.text = string.format(slot2.desc, slot6, (slot3 ~= 0 or slot0:Calculate(slot2.upgrade / slot2.percent * 1, slot0.curSelectID_)) and (slot3 < slot2.lvmax and slot0:Calculate(slot2.upgrade / slot2.percent * slot3, slot0.curSelectID_) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), slot0:Calculate(slot2.upgrade / slot2.percent * (slot3 + 1), slot0.curSelectID_)) or slot0:Calculate(slot2.upgrade / slot2.percent * slot3, slot0.curSelectID_)))
end

function slot0.Calculate(slot0, slot1, slot2)
	if table.indexof(GameDisplayCfg.equip_hero_skill_int.value, slot2) then
		return slot1
	else
		return string.format("%.1f%%", slot1)
	end
end

function slot0.SaveData(slot0)
	EquipAction.ArmHeroEquipSkill(slot0.equipID_, slot0.useList_)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		if not checkGold(slot0.costInfo_[1][2], false) then
			slot0.costNum_.text = "<color=#FF0000>" .. slot2[2] .. "</color>"
		else
			slot0.costNum_.text = slot2[2]
		end
	end
end

function slot0.OnEquipHeroSkillUp(slot0)
	slot0.scrollHelper_:Refresh()
	slot0:RefreshInfo()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:SaveData()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.costItem_) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
