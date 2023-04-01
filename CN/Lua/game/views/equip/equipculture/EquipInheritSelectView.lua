slot0 = class("EquipInheritSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipInheritSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnStateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItem)

	slot0:InitEquipDropdownData()

	slot0.equipInfoView_ = EquipInheritInfoView.New(slot0.infoGo_)

	SetActive(slot0.infoGo_, true)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if EquipData:GetEquipData(uv0.curSelectEquipID_).is_lock == true then
			ShowTips("EQUIP_INHERIT_LOCK")

			return
		end

		if uv0.curSelectEquipInfo_.equiping ~= nil then
			slot1 = HeroCfg[uv0.curSelectEquipInfo_.equiping.heroId]

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("EQUIP_INHERIT_HERO"), string.format("%s·%s", slot1.name, slot1.suffix)),
				OkCallback = function ()
					if ProposalData:GetEquipMap()[uv0.curSelectEquipID_] ~= nil then
						ShowMessageBox({
							title = GetTips("PROMPT"),
							content = GetTips("EQUIP_INHERIT_PROPOSAL"),
							OkCallback = function ()
								uv0.params_.selectEquipHandler(uv0.curSelectEquipInfo_)
								uv0:Back()
							end
						})

						return
					end

					uv0.params_.selectEquipHandler(uv0.curSelectEquipInfo_)
					uv0:Back()
				end
			})

			return
		end

		if ProposalData:GetEquipMap()[uv0.curSelectEquipID_] ~= nil then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_INHERIT_PROPOSAL"),
				OkCallback = function ()
					uv0.params_.selectEquipHandler(uv0.curSelectEquipInfo_)
					uv0:Back()
				end
			})

			return
		end

		uv0.params_.selectEquipHandler(uv0.curSelectEquipInfo_)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.removeBtn_, nil, function ()
		uv0.params_.selectEquipHandler(nil)
		uv0:Back()
	end)
	slot0:AddToggleListener(slot0.suitDropdown_, function (slot0)
		uv0.selectedSuitId_ = slot0

		uv0:RefreshList()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.equipID_ = slot0.params_.equipID
	slot0.equipCfg_ = EquipCfg[EquipData:GetEquipData(slot0.equipID_).prefab_id]

	if slot0.suitDropdown_.value ~= 0 then
		slot0.suitDropdown_.value = 0
	else
		slot0.selectedSuitId_ = 0

		slot0:RefreshList()
	end

	slot0:RefreshBtnState()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.selectedSuitId_ = nil
	slot0.curSelectEquipID_ = nil
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()

	slot0.list_ = nil

	slot0.equipInfoView_:Dispose()

	slot0.equipInfoView_ = nil
end

function slot0.RefreshList(slot0)
	slot0.equipIDList_ = slot0:GetEquipList()

	if #slot0.equipIDList_ > 0 then
		SetActive(slot0.rightPanelGo_, true)

		slot0.curSelectEquipID_ = slot0.params_.selectEquipID or slot0.equipIDList_[1]
		slot1 = EquipData:GetEquipData(slot0.curSelectEquipID_)
		slot1.isKeep = true

		slot0.equipInfoView_:RefreshData(slot0, slot1)
	else
		SetActive(slot0.rightPanelGo_, false)
	end

	if table.keyof(slot0.equipIDList_, slot0.curSelectEquipID_) ~= nil then
		slot0.list_:StartScroll(#slot0.equipIDList_, slot1)
	else
		slot0.list_:StartScroll(#slot0.equipIDList_)
	end
end

function slot0.RefreshBtnState(slot0)
	if slot0.curSelectEquipID_ == slot0.params_.selectEquipID then
		slot0.btnStateController_:SetSelectedState("remove")
	else
		slot0.btnStateController_:SetSelectedState("add")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetSelectType("common")

	slot4 = slot0.equipInfoList_[slot0.equipIDList_[slot1]]

	slot2:RefreshData(slot4)
	slot2:RegistCallBack(function (slot0)
		uv0:ClickItem(slot0)
	end)
	slot2:ShowSelect(slot0.curSelectEquipID_ == slot4.equip_id)

	if slot0.curSelectEquipID_ == slot4.equip_id then
		slot0.curSelectEquipInfo_ = slot4
	end
end

function slot0.ClickItem(slot0, slot1)
	slot2 = EquipData:GetEquipData(slot1.equip_id)
	slot2.isKeep = true
	slot7 = slot2

	slot0.equipInfoView_:RefreshData(slot0, slot7)

	slot0.curSelectEquipID_ = slot1.equip_id
	slot0.curSelectEquipInfo_ = slot1

	for slot7, slot8 in pairs(slot0.list_:GetItemList()) do
		slot8:ShowSelect(slot0.curSelectEquipID_ == slot8.info_.equip_id)
	end

	slot0:RefreshBtnState()
end

function slot0.InitEquipDropdownData(slot0)
	slot0.suitDropdown_.options:Clear()

	slot8 = string.format(GetTips("ALL_EQUIP"))

	slot0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot8, getSprite("Atlas/EquipSkillIconAtlas", "sifting_all")))

	for slot7, slot8 in ipairs(EquipCfg.get_id_list_by_suit) do
		slot9 = EquipSuitCfg[slot7]

		slot0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot9.name, AtlasManager.GetSpriteWithoutAtlas(SpritePathCfg.EquipIcon.path .. slot9.equip_skill_icon)))
	end

	slot0.suitDropdown_:RefreshShownValue()
end

function slot0.GetEquipList(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(EquipData:GetEquipList()) do
		slot8 = EquipCfg[slot7.prefab_id]

		if slot7.equip_id ~= slot0.equipID_ and slot8.starlevel >= 5 and slot8.pos == slot0.equipCfg_.pos and (slot0.selectedSuitId_ == 0 or slot8.suit == slot0.selectedSuitId_) then
			slot2[#slot2 + 1] = slot7.equip_id
		end
	end

	table.sort(slot2, function (slot0, slot1)
		slot2 = EquipData:GetEquipData(slot0)
		slot3 = EquipData:GetEquipData(slot1)

		if slot0 == uv0.curSelectEquipID_ then
			return true
		elseif slot1 == uv0.curSelectEquipID_ then
			return false
		end

		if EquipTools.CountEquipLevel(slot2) ~= EquipTools.CountEquipLevel(slot3) then
			return slot4 < slot5
		end

		slot6 = false
		slot7 = false
		slot8, slot7 = uv0:RebuildSorter(slot2, slot3)

		if slot8 then
			return slot7
		end

		slot8, slot7 = uv0:SkillSorter(slot2, slot3)

		if slot8 then
			return slot7
		end

		slot8, slot7 = uv0:EnchantSorter(slot2, slot3)

		if slot8 then
			return slot7
		end

		slot8, slot7 = uv0:RaceSorter(slot2, slot3)

		if slot8 then
			return slot7
		end

		slot8, slot7 = uv0:SuitSorter(slot2, slot3)

		if slot8 then
			return slot7
		end

		return slot2.prefab_id < slot3.prefab_id
	end)

	slot3 = HeroData:GetEquipMap()
	slot0.equipInfoList_ = {}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = EquipData:GetEquipData(slot8)
		slot10 = nil

		if slot3[slot8] then
			slot10 = {
				heroId = slot3[slot8]
			}
		end

		slot0.equipInfoList_[slot8] = {
			number = 1,
			type = ItemCfg[slot9.prefab_id].type,
			id = slot9.prefab_id,
			equip_id = slot9.equip_id,
			equip_info = slot9,
			equip_star = getItemStar(slot9.prefab_id),
			equip_lv = EquipTools.CountEquipLevel(slot9),
			equiping = slot10
		}
	end

	return slot2
end

function slot0.RebuildSorter(slot0, slot1, slot2)
	slot4 = slot2.race
	slot5 = 1
	slot6 = 1

	if slot1.race ~= 0 then
		slot5 = table.keyof(RaceEffectCfg.all, slot3) ~= nil and 2 or 3
	end

	if slot4 ~= 0 then
		slot6 = table.keyof(RaceEffectCfg.all, slot4) ~= nil and 2 or 3
	end

	if slot5 ~= slot6 then
		return true, slot5 < slot6
	end

	return false, false
end

function slot0.SkillSorter(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in pairs(slot1.skillList) do
		slot3 = slot3 + slot9.level
	end

	for slot8, slot9 in pairs(slot2.skillList) do
		slot4 = slot4 + slot9.level
	end

	if slot3 ~= slot4 then
		return true, slot3 < slot4
	end

	return false, false
end

function slot0.EnchantSorter(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(slot1.enchant) do
		if #slot9 > 0 then
			slot3 = slot3 + 1
		end
	end

	for slot8, slot9 in ipairs(slot2.enchant) do
		if #slot9 > 0 then
			slot4 = slot4 + 1
		end
	end

	if slot3 ~= slot4 then
		return true, slot3 < slot4
	end

	return false, false
end

function slot0.RaceSorter(slot0, slot1, slot2)
	if EquipCfg[slot1.prefab_id].race ~= EquipCfg[slot2.prefab_id].race then
		return true, slot3.race < slot4.race
	end

	return false, false
end

function slot0.SuitSorter(slot0, slot1, slot2)
	if EquipCfg[slot1.prefab_id].suit ~= EquipCfg[slot2.prefab_id].suit then
		return true, slot3.suit < slot4.suit
	end

	return false, false
end

return slot0
