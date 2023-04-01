slot0 = class("EquipStrengthView", EquipBaseView)
slot1 = import("game.const.MaterialConst")
slot2 = import("game.const.ItemConst")
slot3 = import("game.const.HeroConst")
slot4 = import("game.const.EquipConst")
slot5 = import("game.tools.EquipTools")

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipStrengthUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0, 1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeNameS_ = {
		[uv0.EQUIP_SORT.LEVEL] = "lv",
		[uv0.EQUIP_SORT.RARE] = "star"
	}
	slot0.toggle_ = {}
	slot0.toggleSelect_ = {}
	slot0.toggleUnSelect_ = {}
	slot0.toggleSort_ = {}
	slot0.item_ = Asset.Load("UI/Common/CommonItem")
	slot4 = slot0.listGo_
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot4, CommonItem)
	slot0.attrs = {}

	for slot4 = 1, 2 do
		slot5 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["m_property" .. slot4])
		table.insert(slot0.attrs, slot5)
	end

	slot0.equipDropDown_ = slot0.equipDropDownGo_.transform:GetComponent("Dropdown")
	slot0.orderController_ = ControllerUtil.GetController(slot0.sortBtn_.gameObject.transform, "order")
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnAutoSelect_, nil, function ()
		uv0:HideMaskMessage()

		slot4 = {}

		table.insert(slot4, uv0.equipId)

		uv0.usedMaterialList_, uv0.usedEquipList_ = uv1.QuickSelectList(uv1.CountNeedExp(uv0.equip, EquipCfg[uv0.equip.prefab_id].max_level[uv0.equip.now_break_level + 1], uv0.equip.now_break_level) - uv0.equip.exp, slot4)

		uv0:RefreshListSelect()
	end)
	slot0:AddBtnListener(slot0.btnStrength_, nil, function ()
		uv0:HideMaskMessage()

		slot0 = false

		for slot4, slot5 in pairs(uv0.usedMaterialList_) do
			if slot5 > 0 then
				slot0 = true
			end
		end

		if not slot0 and next(uv0.usedEquipList_) == nil then
			ShowTips(GetTips("PLEASE_SELECT_ITEM"))

			return
		end

		if not checkGold(uv0.cost_) then
			return
		end

		slot1 = false

		for slot5, slot6 in pairs(uv0.usedEquipList_) do
			if slot6.equip_star >= 5 then
				slot1 = true

				break
			end
		end

		slot2 = false
		slot7 = MaterialTools.materialGiveBack(uv0.equip.exp + uv1.CountAddExp(uv0.usedMaterialList_, uv0.usedEquipList_) - uv1.CountNeedExp(uv0.equip, uv1.CountEquipMaxLv(uv0.equip), uv0.equip.now_break_level), uv2.STR_ITEM.EQUIP)

		function slot8(slot0, slot1)
			for slot5, slot6 in pairs(slot1) do
				slot0[#slot0 + 1] = slot6
			end
		end

		for slot12, slot13 in pairs(uv0.usedEquipList_) do
			slot8(slot7, EquipData:GetEquipData(slot12):GetBreakCostReturn())
		end

		if #sortReward(mergeReward(slot7)) > 0 then
			slot2 = true
		end

		slot9 = ""

		if slot1 and slot2 then
			slot9 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW_AND_RARE"))
		elseif slot1 and not slot2 then
			slot9 = GetTips("EQUIP_STRENGTH_COST_RARE")
		elseif not slot1 and slot2 then
			slot9 = string.format(GetTips("EQUIP_STRENGTH_EXP_OVERFLOW"))
		else
			EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_, slot6)

			return
		end

		if slot1 and not slot2 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = slot9,
				OkCallback = function ()
					EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_)
				end
			})

			return
		end

		uv0:Go("materialPreview", {
			content = slot9,
			OkCallback = function ()
				EquipAction.ApplyStrengthEquip(tonumber(uv0.equipId), uv0.usedEquipList_, uv0.usedMaterialList_, uv0.cost_, uv1)
			end,
			itemList = slot7
		})
	end)
	slot0:AddToggleListener(slot0.equipDropDown_, function (slot0)
		slot1 = nil

		if slot0 == 0 then
			slot1 = uv0.EQUIP_SORT.LEVEL

			OperationRecorder.Record("equip", "equipSortLevel")
		else
			slot1 = uv0.EQUIP_SORT.RARE

			OperationRecorder.Record("equip", "equipSortRare")
		end

		uv1:ChangeEquipSelectView(slot1, uv1.params_.order or 0)
	end)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		uv0:ChangeEquipSelectView(uv0.params_.priority or uv1.EQUIP_SORT.LEVEL, 1 - (uv0.params_.order or 0))
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.itemList[slot1]

	slot2:RefreshData(slot3)
	slot2:ShowLock(slot3.isLock)
	slot2:ShowEquiping(slot3.isEquiped)

	if slot3.type == uv0.ITEM_TYPE.EQUIP then
		slot2:RegistCallBack(function (slot0)
			OperationRecorder.Record("equip", "strengthSelectMaterial")

			if uv0.usedEquipList_[slot0.equip_id] then
				uv1:ShowSelect(0)

				uv0.usedEquipList_[slot1] = nil

				uv0:HideMaskMessage()
			else
				slot2 = slot0.equip_id

				if uv2.CountEquipMaxLv(uv0.equip) <= uv0.nextLv_ then
					ShowTips("ERROR_USER_MAX_LV")

					return
				end

				if EquipData:GetEquipData(slot2).is_lock then
					ShowTips("REMOVE_LOCK")
					uv0:ShowEquipInfo(slot2, uv1)

					return
				end

				uv0:ShowEquipInfo(slot2, uv1)
				uv1:ShowSelect(1)

				uv0.usedEquipList_[slot2] = slot0
			end

			uv0:RefreshEquipExpInfo()
		end)
		slot2:ShowSelect(slot0.usedEquipList_[slot3.equip_id] and 1 or 0)
	elseif slot3.type == uv0.ITEM_TYPE.MATERIAL then
		slot2:RegistLongCallBack(function (slot0)
			uv0:HideMaskMessage()

			if uv1.CountEquipMaxLv(uv0.equip) <= uv0.nextLv_ then
				ShowTips("ERROR_USER_MAX_LV")

				return false
			end

			uv0.usedMaterialList_[slot0.id] = uv0.usedMaterialList_[slot0.id] or 0

			if slot0.number <= uv0.usedMaterialList_[slot0.id] then
				return false
			end

			uv0.usedMaterialList_[slot0.id] = uv0.usedMaterialList_[slot0.id] + 1

			uv2:ShowSelect(uv0.usedMaterialList_[slot0.id])
			uv0:RefreshEquipExpInfo()
			manager.audio:PlayUIAudio(2)

			return true
		end)
		slot2:RegistCutCallBack(function (slot0)
			OperationRecorder.Record("equip", "reduceMaterialNumber")

			uv0.usedMaterialList_[slot0.id] = uv0.usedMaterialList_[slot0.id] or 0

			if uv0.usedMaterialList_[slot0.id] <= 0 then
				return false
			end

			uv0.usedMaterialList_[slot0.id] = uv0.usedMaterialList_[slot0.id] - 1

			uv1:ShowSelect(uv0.usedMaterialList_[slot0.id])
			uv0:RefreshEquipExpInfo()
			manager.audio:PlayUIAudio(2)

			return true
		end)
		slot2:ShowSelect(slot0.usedMaterialList_[slot3.id] or 0)
	end
end

function slot0.ChangeEquipSelectView(slot0, slot1, slot2)
	slot0.orderController_:SetSelectedState(slot2 == 1 and "asc" or "desc")

	slot0.params_.priority = slot1
	slot0.params_.order = slot2
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshList()
end

function slot0.RefreshList(slot0)
	slot0.scrollHelper:StartScroll(#slot0.itemList)
end

function slot0.RefreshEquip(slot0)
	slot0:RefreshEquipExpInfo()
end

function slot0.RefreshListSelect(slot0)
	slot3 = slot0.scrollHelper
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		if slot5:GetItemInfo().type == uv0.ITEM_TYPE.MATERIAL then
			slot5:ShowSelect(slot0.usedMaterialList_[slot6.id] or 0)
		elseif slot6.type == uv0.ITEM_TYPE.EQUIP then
			slot5:ShowSelect(slot0.usedEquipList_[slot6.equip_id] and 1 or 0)
		end
	end

	slot0:RefreshEquipExpInfo()
end

function slot0.RefreshEquipExpInfo(slot0)
	slot2 = slot0.equip
	slot3 = EquipCfg[slot2.prefab_id]
	slot4 = slot2.exp + uv0.CountAddExp(slot0.usedMaterialList_, slot0.usedEquipList_)
	slot5 = deepClone(slot2)
	slot5.exp = slot4
	slot7 = uv0.CountEquipLevel(slot5)
	slot0.nextLv_ = slot7
	slot9 = slot4 - uv0.CountNeedExp(slot2, slot7, slot2.now_break_level)

	SetActive(slot0.btnAutoSelectGo_, uv0.CountEquipLevel(slot2) < uv0.CountEquipMaxLv(slot2))
	SetActive(slot0.btnStrengthGo_, slot6 < slot10)
	SetActive(slot0.btnAutoSelectNullGo_, slot6 == slot10)

	slot0.cost_ = 0

	if slot0.equip.exp + slot1 - uv0.CountNeedExp(slot2, slot10, slot2.now_break_level) < 0 then
		slot11 = 0
	end

	slot0.addExpText_.text = "+" .. slot1 - slot11

	if slot10 <= slot7 then
		slot0.cost_ = math.floor((slot8 - slot2.exp < 0 and 0 or slot12) * GameSetting.equip_strengthen_gold_cost.value[1])
		slot0.expNum_.text = "-/-"
		slot0.expProg_.fillAmount = 0
		slot0.newExpProg_.fillAmount = 1

		SetActive(slot0.maxGo_, true)
	else
		slot0.cost_ = math.floor(slot1 * GameSetting.equip_strengthen_gold_cost.value[1])
		slot0.expNum_.text = slot9 .. "/" .. EquipExpCfg[slot7]["exp" .. slot3.starlevel]

		if slot7 == slot6 then
			slot0.expProg_.fillAmount = (slot9 - slot1) / slot12
		else
			slot0.expProg_.fillAmount = 0
		end

		slot0.newExpProg_.fillAmount = slot9 / slot12

		SetActive(slot0.maxGo_, false)
	end

	slot13 = tostring(slot0.cost_)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot0.cost_ then
		slot13 = "<color='#FF0000'>" .. slot13 .. "</color>"
	end

	slot0.costNum_.text = slot13
	slot0.oldLv_.text = "" .. slot6
	slot0.newLv_.text = "" .. slot7
	slot15 = uv0.CountEquipAttribute(slot5)
	slot16 = 1

	for slot20, slot21 in pairs(uv0.CountEquipAttribute(slot2)) do
		slot22 = PublicAttrCfg[slot20]

		if not slot0.attrs[slot16] then
			break
		end

		slot24 = math.floor(slot21)
		slot25 = math.floor(slot15[slot20])

		if slot22.percent and slot22.percent == 1 then
			slot24 = slot21 / 10 .. "%"
			slot25 = slot15[slot20] / 10 .. "%"
		end

		slot23.m_name.text = slot22.name
		slot23.m_icon.sprite = getSprite("Atlas/Common", slot22.icon)
		slot23.m_attrOld.text = slot24

		if slot21 ~= slot15[slot20] then
			slot23.m_attrNew.text = "<color='#FF7100'>" .. slot25 .. "</color>"

			SetActive(slot23.m_select, true)

			slot23.m_arrow.color = Color.New(1, 0.4431373, 0, 1)
		else
			slot23.m_attrNew.text = "<color='#393B43'>" .. slot25 .. "</color>"

			SetActive(slot23.m_select, false)

			slot23.m_arrow.color = Color.New(0.2220578, 0.2328396, 0.2620182, 1)
		end

		slot16 = slot16 + 1
	end
end

function slot0.GetEquip(slot0)
	return EquipData:GetEquipData(slot0.equipId)
end

function slot0.GetItemList(slot0)
	slot4 = EquipData:GetEquipListComplex(tonumber(slot0.params_.order) or uv0.SORT_TYPE.UP, tonumber(slot0.params_.priority) or uv1.EQUIP_SORT.RARE, 0, tonumber(slot0.params_.suit) or 0)
	slot5 = {}
	slot9 = uv0.ITEM_TYPE.MATERIAL

	for slot9, slot10 in ipairs(ItemCfg.get_id_list_by_type[slot9]) do
		slot12 = ItemCfg[slot10]

		if MaterialData:GetMaterialList()[slot10] and slot12.sub_type == uv2.MATERIAL_TYPE.EQUIP_LEVEL_UP and slot11.num > 0 then
			table.insert(slot5, {
				type = ItemCfg[slot10].type,
				id = slot10,
				number = slot11.num
			})
		end
	end

	slot6 = HeroData:GetEquipMap()
	slot7 = ProposalData:GetEquipMap()

	for slot11 = #slot4, 1, -1 do
		if slot6[slot4[slot11]] or slot4[slot11] == slot0.equipId then
			table.remove(slot4, slot11)
		end
	end

	for slot11, slot12 in ipairs(slot4) do
		slot13 = EquipData:GetEquipData(slot12)
		slot14 = {
			number = 1,
			isEquiped = false,
			type = ItemCfg[slot13.prefab_id].type,
			id = slot13.prefab_id,
			equip_id = slot13.equip_id,
			equip_info = slot13,
			equip_star = getItemStar(slot13.prefab_id),
			equip_lv = uv3.CountEquipLevel(slot13),
			isLock = slot13.is_lock
		}

		if not slot13.is_lock and not slot7[slot13.equip_id] then
			table.insert(slot5, slot14)
		end
	end

	return slot5 or {}
end

function slot0.OnEnter(slot0)
	slot0.usedMaterialList_ = {}
	slot0.usedEquipList_ = {}
	slot0.equipId = slot0.params_.equipId
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshEquip()
	slot0:ChangeEquipSelectView(uv0.EQUIP_SORT.LEVEL, uv1.SORT_TYPE.UP)

	slot0.equipDropDown_.value = 0

	slot0.orderController_:SetSelectedState("asc")
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.usedMaterialList_ = {}
	slot0.usedEquipList_ = {}
	slot0.equipId = slot1
	slot0.params_.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshEquip()
	slot0:ChangeEquipSelectView(uv0.EQUIP_SORT.LEVEL, uv1.SORT_TYPE.UP)

	slot0.equipDropDown_.value = 0

	slot0.orderController_:SetSelectedState("asc")
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.toggleSort_) do
		slot5.localEulerAngles = Vector3.New(0, 0, 180)
	end

	slot0.isOnIndex = nil

	slot0:HideMaskMessage()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.toggle_ then
		for slot4, slot5 in pairs(slot0.toggle_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.toggle_ = nil
		slot0.toggleSelect_ = nil
		slot0.toggleUnSelect_ = nil
	end

	if slot0.scrollHelper then
		slot0.scrollHelper:Dispose()

		slot0.scrollHelper = nil
	end

	if slot0.itemPool_ then
		slot0.itemPool_:Dispose()

		slot0.itemPool_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.ShowEquipInfo(slot0, slot1, slot2)
	SetActive(slot0.equipInfoGo_, true)
	SetActive(slot0.maskGo_, true)

	slot3 = EquipData

	slot0:RefreshEquipInfo(slot3:GetEquipData(slot1), function (slot0)
		if slot0 then
			uv0:ShowSelect(0)

			uv1.usedEquipList_[uv2] = nil

			uv1:RefreshEquipExpInfo()
		end

		uv0:ShowLock(slot0)
	end)
end

function slot0.OnEquipStrengthSuccess(slot0)
	slot0.itemList = slot0:GetItemList()

	slot0:RefreshList()
	slot0:RefreshEquipExpInfo()

	slot0.usedMaterialList_ = {}
	slot0.usedEquipList_ = {}

	slot0:RefreshListSelect()
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshEquipExpInfo()
	end
end

return slot0
