slot0 = class("BagView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Bag/BagUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.itemList_ = {}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "page")
	slot0.equipDeepController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "equipDeep")
	slot0.chooseTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "chooseType")
	slot0.orderController_ = ControllerUtil.GetController(slot0.sortBtn_.gameObject.transform, "order")
	slot0.toggles_ = {
		slot0.materialToggle_,
		slot0.heropieceToggle_,
		slot0.weaponservantToggle_,
		slot0.mintmarkToggle_,
		slot0.giftToggle_
	}
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItem)
	slot0.suitScrollHelper = LuaList.New(handler(slot0, slot0.indexSuitItem), slot0.suitListGo_, SuitItem)
	slot0.skillScrollHelper = LuaList.New(handler(slot0, slot0.indexSkillItem), slot0.skillListGo_, SkillSelectItem)
	slot0.equipDropDown_ = slot0.equipDropDownGo_.transform:GetComponent("Dropdown")
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SwitchToPageByIndex(uv1, true)

				if uv1 == 1 then
					OperationRecorder.Record("BagView", "material")

					uv0.emptyText_.text = GetTips("NO_MATERIAL")
				elseif uv1 == 2 then
					OperationRecorder.Record("BagView", "qingbao")

					uv0.emptyText_.text = GetTips("NO_HERO_PIECE")
				elseif uv1 == 4 then
					OperationRecorder.Record("BagView", "equip")

					uv0.emptyText_.text = GetTips("NO_EQUIP")
				elseif uv1 == 5 then
					OperationRecorder.Record("BagView", "gift")

					uv0.emptyText_.text = GetTips("NO_GIFT")
				end
			end
		end)
	end

	slot0:AddToggleListener(slot0.equipDropDown_, function (slot0)
		slot1 = nil

		if slot0 == 0 then
			slot1 = EquipConst.EQUIP_SORT.LEVEL

			OperationRecorder.Record("BagView", "sort_level")
		else
			slot1 = EquipConst.EQUIP_SORT.RARE

			OperationRecorder.Record("BagView", "sort_rare")
		end

		uv0:ChangeEquipSelectView(slot1, uv0.params_.order or 0)
	end)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		uv0:ChangeEquipSelectView(uv0.params_.priority or EquipConst.EQUIP_SORT.LEVEL, 1 - (uv0.params_.order or 0))
	end)
	slot0:AddToggleListener(slot0.suitToggle_, function (slot0)
		if slot0 then
			uv0.chooseTypeController_:SetSelectedState("suit")
			uv0:SwitchSelectType("suit")
			OperationRecorder.Record("BagView", "suit")
		end
	end)
	slot0:AddToggleListener(slot0.skillsToggle_, function (slot0)
		if slot0 then
			uv0.chooseTypeController_:SetSelectedState("skills")
			uv0:SwitchSelectType("skills")
			OperationRecorder.Record("BagView", "skills")
		end
	end)
	slot0:AddBtnListener(slot0.decomposeBtn_, nil, function ()
		slot0 = deepClone(uv0.params_)
		slot0.order = ItemConst.SORT_TYPE.UP
		slot0.priority = EquipConst.EQUIP_SORT.LEVEL

		JumpTools.GoToSystem("/equipDecompose", slot0, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialUpdate))
	slot0:RegistEventListener(MATERIAL_LIST_UPDATE, handler(slot0, slot0.OnMaterialListUpdate))
	slot0:RegistEventListener(EQUIP_LIST_UPDATE, handler(slot0, slot0.OnEquipListUpdate))
end

function slot0.OnEquipListUpdate(slot0)
	if slot0.pageController_:GetSelectedState() ~= "equip" then
		return
	end

	slot0:UpdatePageView()
end

function slot0.OnMaterialUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot0.pageController_:GetSelectedState() ~= "material" and slot0.pageController_:GetSelectedState() ~= "gift" then
		return
	end

	for slot9, slot10 in pairs(slot0.scrollHelper:GetItemList()) do
		if slot10.info_.id == slot1 and slot10.info_.time_valid == slot2 then
			slot10:SetBottomText(tostring(slot3))
		end
	end

	for slot9, slot10 in pairs(slot0.itemList_) do
		if slot10.id == slot1 and slot10.time_valid == slot2 then
			slot10.number = slot3
		end
	end
end

function slot0.OnMaterialListUpdate(slot0, slot1)
	if slot0.pageController_:GetSelectedState() ~= "material" and slot0.pageController_:GetSelectedState() ~= "gift" then
		return
	end

	slot0:UpdatePageView()
end

function slot0.ChangeEquipSelectView(slot0, slot1, slot2)
	slot0.orderController_:SetSelectedState(slot2 == 1 and "asc" or "desc")

	slot0.params_.priority = slot1
	slot0.params_.order = slot2

	slot0:SaveParams()
	slot0:UpdatePageView()
end

function slot0.SwitchToPage(slot0, slot1, slot2)
	slot0.pageController_:SetSelectedState(slot1)

	slot0.params_.type = slot1

	if slot0:GetToggle(slot1) then
		slot3.isOn = true
	end

	if slot1 == "equip" and slot2 then
		slot0:SwitchSelectType("suit")
	else
		slot0:UpdatePageView()
	end
end

function slot0.OnTop(slot0)
	slot1 = slot0:CheckExpiredList()

	if tostring(slot0.params_.type) ~= tostring(slot0.pageController_:GetSelectedState()) then
		slot0:ResetParams()
		slot0:SwitchToPage(slot0.params_.type)
	elseif slot1 then
		slot0:SwitchToPage(slot0.params_.type)
	end

	slot0:CheckCooperationInviteEntry()
	slot0:UpdateBar()
end

function slot0.OnNotifyForBagRefreshBug(slot0)
	if slot0.pageController_:GetSelectedState() == "gift" then
		slot0:UpdatePageData()
		slot0.scrollHelper:StartScroll(#slot0.itemList_, 1)
	end
end

function slot0.GetToggle(slot0, slot1)
	return slot0.toggles_[table.indexof({
		"material",
		"heropiece",
		"servant",
		"equip",
		"gift"
	}, slot1)]
end

function slot0.SwitchToPageByIndex(slot0, slot1, slot2)
	slot3 = slot0.pageController_:GetSelectedState()

	slot0.pageController_:SetSelectedIndex(slot1 - 1)

	if slot0.params_.type == slot0.pageController_:GetSelectedState() then
		return
	end

	slot0:RecordStay(slot3)

	slot0.params_.type = slot0.pageController_:GetSelectedState()

	if slot0.pageController_:GetSelectedState() == "equip" and slot2 then
		slot0:SwitchSelectType("suit")
	else
		slot0:UpdatePageView()
	end
end

function slot0.SwitchSelectType(slot0, slot1)
	slot0.params_.selectType_ = slot1

	slot0.chooseTypeController_:SetSelectedState(slot1)
	slot0.equipDeepController_:SetSelectedState("category")

	if slot1 == "suit" then
		slot0.suitToggle_.isOn = true

		slot0:UpdateSuitList()
		slot0.suitScrollHelper:StartScroll(#slot0.haveSuitList_ + 1, 1)
	else
		slot0.skillsToggle_.isOn = true

		slot0:UpdateSkillList()
		slot0.skillScrollHelper:StartScroll(#slot0.haveSkillList_ + 1, 1)
	end
end

function slot0.UpdatePageData(slot0)
	slot0.itemList_ = {}

	if slot0.pageController_:GetSelectedState() == "material" then
		slot0.itemList_ = slot0:GetMaterialData()
	elseif slot1 == "heropiece" then
		slot0.itemList_ = slot0:GetHeroPieceData()
	elseif slot1 == "servant" then
		slot0.itemList_ = slot0:GetWeaponServantData()
	elseif slot1 == "equip" then
		slot0.itemList_ = slot0:GetEquipData()
	elseif slot1 == "gift" then
		slot0.itemList_ = slot0:GetGiftData()
	end
end

function slot0.UpdatePageView(slot0)
	slot0.equipDeepController_:SetSelectedState("list")
	slot0:UpdatePageData()

	if slot0.lastPosition_ ~= nil then
		slot0.scrollHelper:StartScrollByPosition(#slot0.itemList_, slot0.lastPosition_)

		slot0.lastPosition_ = nil
	else
		slot0.scrollHelper:StartScroll(#slot0.itemList_, 1)
	end

	if slot0.pageController_:GetSelectedState() == "equip" then
		slot0:UpdateEquipNum()
	end
end

function slot0.UpdateEquipNum(slot0)
	slot0.num_.text = string.format("%d", EquipTools.GetEquipNum())
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.pageController_:GetSelectedState() == "equip" and uv0.equipDeepController_:GetSelectedState() == "list" then
			uv0.equipDeepController_:SetSelectedState("category")
			uv0:SwitchSelectType(uv0.params_.selectType_ or "suit")
		else
			JumpTools.Back()
		end
	end)
end

function slot0.ClearCaches(slot0)
	slot0.params_.type = nil
	slot0.params_.priority = nil
	slot0.params_.selectType_ = nil
	slot0.params_.suit = nil
	slot0.params_.skill = nil
	slot0.params_.order = nil
	slot0.params_.suitPos = nil
	slot0.equipDropDown_.value = 0

	slot0.orderController_:SetSelectedState("desc")

	slot0.lastPosition_ = nil
	slot0.savedParams_ = {}
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		OperationRecorder.Record("NewBagView", "bag_qingbao_item")

		if ItemCfg[slot0.id].type == ItemConst.ITEM_TYPE.EQUIP then
			ShowPopItem(POP_OPERATE_ITEM, slot0)
		elseif slot2 == ItemConst.ITEM_TYPE.HERO_PIECE then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number,
				0,
				ItemTools.GetItemExpiredTimeByInfo(slot0)
			})
		elseif slot2 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			uv0:Go("/weaponServant", {
				state = "detail",
				uid = slot0.uid
			})
		else
			slot3 = ItemTools.GetItemExpiredTimeByInfo(slot0)

			if ItemMergeCfg.get_id_list_by_sourceId[slot0.id] ~= nil and #slot4 > 0 then
				ShowPopItem(POP_MERGE_ITEM, {
					slot0.id,
					slot0.number,
					0,
					slot3
				})
			else
				ShowPopItem(POP_OPERATE_ITEM, {
					slot0.id,
					slot0.number,
					0,
					slot3
				})
			end
		end
	end)
	slot2:RefreshData(slot0.itemList_[slot1])

	if slot2:GetItemInfo().type == ItemConst.ITEM_TYPE.MATERIAL then
		slot2:UpdateTime()
	else
		ControllerUtil.GetController(slot2.countdownGo_.transform, "countdownStatus"):SetSelectedState("noLimit")
	end
end

function slot0.indexSuitItem(slot0, slot1, slot2)
	slot3 = 0

	if slot1 > 1 then
		slot3 = slot0.haveSuitList_[slot1 - 1]
	end

	if slot3 ~= nil then
		if slot3 >= 0 then
			slot2:RefreshData(slot0, {
				id = slot3
			})
			slot2:SetBottomText(EquipTools.GetSuitEquipNum(slot3))
			slot2:RegistCallBack(function ()
				if uv0 == 0 then
					OperationRecorder.Record("BagView", "suit0")
				else
					OperationRecorder.Record("BagView", "suitgt0")
				end

				uv1.params_.suit = uv0
				uv1.params_.skill = 0

				uv1:UpdatePageView()
			end)
		end
	else
		slot4 = ""

		for slot8, slot9 in pairs(slot0.haveSuitList_) do
			slot4 = slot4 .. string.format("suit[%s] = %s, ", tostring(slot8), tostring(slot9))
		end

		CustomLog.LogError(string.format("id is null, has Ex equip = %s, index = %d, len = %d, suitString = %s", tostring(EquipTools.GetIsHaveExEquip()), slot1, #slot0.haveSuitList_, slot4))
	end
end

function slot0.indexSkillItem(slot0, slot1, slot2)
	slot3 = 0

	if slot1 > 1 then
		slot3 = slot0.haveSkillList_[slot1 - 1]
	end

	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:SetBottomText(EquipTools.GetEquipSkillNum(slot3))
	slot2:RegistCallBack(function ()
		if uv0 == 0 then
			OperationRecorder.Record("BagView", "skill0")
		else
			OperationRecorder.Record("BagView", "skillgt0")
		end

		uv1.params_.skill = uv0
		uv1.params_.suit = 0

		uv1:UpdatePageView()
	end)
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.UpdateTimer(slot0)
	if slot0.params_.type ~= "material" then
		return
	end

	for slot5, slot6 in pairs(slot0.scrollHelper:GetItemList()) do
		slot6:UpdateTime()
	end

	slot0:RefreshVitalityLimit()
end

function slot0.RefreshVitalityLimit(slot0)
	slot1 = {}
	slot2 = manager.time:GetServerTime()
	slot7 = ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID

	for slot7, slot8 in ipairs(MaterialData:GetMaterialListBySubTypes({
		slot7
	})) do
		if slot8.time_valid ~= nil and slot8.time_valid ~= 0 and slot2 < slot8.time_valid then
			table.insert(slot1, slot8)
		end
	end

	if #slot1 <= 0 then
		SetActive(slot0.vitalityTimerGo_, false)

		return
	end

	table.sort(slot1, function (slot0, slot1)
		if ((slot0.time_valid or 0) > 0 and 1 or 0) ~= ((slot1.time_valid or 0) > 0 and 1 or 0) then
			return slot5 < slot4
		end

		if slot2 ~= slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)

	slot0.vitalityTimerText_.text = manager.time:GetLostTimeStr(slot1[1].time_valid)

	SetActive(slot0.vitalityTimerGo_, true)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnEnter(slot0)
	slot0:ResetParams()
	slot0:CheckExpiredList()

	slot0.haveSuitList_ = {}

	for slot4, slot5 in pairs(EquipTools.GetHaveSuitList()) do
		if slot5 < EquipConst.EX_EQUIP_SUIT_ID then
			table.insert(slot0.haveSuitList_, slot5)
		end
	end

	slot0.haveSkillList_ = EquipTools.GetHaveSkillList()

	if slot0.params_.type then
		slot0:SwitchToPage(slot0.params_.type)

		if slot0.pageController_:GetStateIndex(slot0.params_.type) + 1 > 0 then
			slot0.toggles_[slot1].isOn = true
		end
	else
		slot0:SwitchToPageByIndex(1)

		slot0.emptyText_.text = GetTips("NO_MATERIAL")
		slot0.toggles_[1].isOn = true
	end

	slot0:UpdateBar()
	slot0:AddEventListeners()
	slot0:RefreshVitalityLimit()
	slot0:StartTimer()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:SaveParams()

	slot0.lastPosition_ = slot0.scrollHelper:GetScrolledPosition()

	manager.windowBar:HideBar()
	slot0:RecordStay(slot0.pageController_:GetSelectedState())
	slot0:StopTimer()
end

function slot0.SaveParams(slot0)
	if slot0.savedParams_ == nil then
		slot0.savedParams_ = {}
	end

	slot0.savedParams_.order = slot0.params_.order
end

function slot0.ResetParams(slot0)
	if slot0.savedParams_ == nil then
		slot0.savedParams_ = {}
	end

	if slot0.params_.order == nil then
		slot0.params_.order = slot0.savedParams_.order
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0:ClearCaches()
end

function slot0.Dispose(slot0)
	if slot0.skillScrollHelper then
		slot0.skillScrollHelper:Dispose()

		slot0.skillScrollHelper = nil
	end

	if slot0.suitScrollHelper then
		slot0.suitScrollHelper:Dispose()

		slot0.suitScrollHelper = nil
	end

	if slot0.scrollHelper then
		slot0.scrollHelper:Dispose()

		slot0.scrollHelper = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetMaterialData(slot0)
	slot1 = {}
	slot4 = MaterialData
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetMaterialListExceptTypes(slot6, {
		ItemConst.ITEM_TYPE.ARCHIVE_GIFT
	})) do
		if slot6.num > 0 and slot6.id ~= 30011 then
			table.insert(slot1, {
				id = slot6.id,
				number = slot6.num,
				type = ItemConst.ITEM_TYPE.MATERIAL,
				time_valid = slot6.time_valid or 0
			})
		end
	end

	slot2 = ipairs
	slot4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.DROP_TICKET] or {}

	for slot5, slot6 in slot2(slot4) do
		if CurrencyData:GetCurrencyByID(slot6).num > 0 then
			table.insert(slot1, {
				id = slot6,
				number = slot7.num,
				type = ItemConst.ITEM_TYPE.CURRENCY
			})
		end
	end

	slot2 = ipairs
	slot4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.CHANGE_NAME_CARD] or {}

	for slot5, slot6 in slot2(slot4) do
		if CurrencyData:GetCurrencyByID(slot6).num > 0 then
			table.insert(slot1, {
				id = slot6,
				number = slot7.num,
				type = ItemConst.ITEM_TYPE.CURRENCY
			})
		end
	end

	table.sort(slot1, function (slot0, slot1)
		slot2 = ItemCfg[slot0.id]
		slot3 = ItemCfg[slot1.id]

		if ItemTools.GetItemExpiredTimeByInfo(slot0) == ItemTools.GetItemExpiredTimeByInfo(slot1) then
			if slot2.use == slot3.use then
				if slot2.type == ItemConst.ITEM_TYPE.CURRENCY and slot3.type ~= ItemConst.ITEM_TYPE.CURRENCY then
					return true
				elseif slot2.type ~= ItemConst.ITEM_TYPE.CURRENCY and slot3.type == ItemConst.ITEM_TYPE.CURRENCY then
					return false
				elseif slot2.rare == slot3.rare then
					return slot3.id < slot2.id
				else
					return slot3.rare < slot2.rare
				end
			else
				return slot3.use < slot2.use
			end
		elseif slot4 ~= 0 and slot5 ~= 0 then
			return slot4 < slot5
		elseif slot5 == 0 then
			return true
		else
			return false
		end
	end)

	return slot1
end

function slot0.GetHeroPieceData(slot0)
	slot1 = {}
	slot4 = HeroData
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetHeroList(slot6)) do
		if slot6.piece > 0 then
			table.insert(slot1, {
				id = ItemCfg[slot6.id].fragment,
				number = slot6.piece,
				type = ItemConst.ITEM_TYPE.HERO_PIECE,
				heroId = slot6.id
			})
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if ItemCfg[slot0.id].rare == ItemCfg[slot1.id].rare then
			return slot3.id < slot2.id
		else
			return slot3.rare < slot2.rare
		end
	end)

	return slot1
end

function slot0.GetWeaponServantData(slot0)
	slot1 = {}
	slot3 = ServantTools.GetServantMap()

	for slot7, slot8 in pairs(WeaponServantData:GetWeaponServantList()) do
		table.insert(slot1, {
			id = slot8.id,
			uid = slot8.uid,
			number = slot8.stage,
			type = ItemConst.ITEM_TYPE.WEAPON_SERVANT,
			race = slot8.race,
			stage = slot8.stage,
			locked = slot8.locked,
			equiping = {
				heroId = slot3[slot8.uid] or 0
			}
		})
	end

	table.sort(slot1, function (slot0, slot1)
		slot2 = WeaponServantCfg[slot0.id].starlevel
		slot3 = WeaponServantCfg[slot1.id].starlevel
		slot6 = WeaponServantCfg[slot0.id].race
		slot7 = WeaponServantCfg[slot1.id].race
		slot8 = slot0.id
		slot9 = slot1.id
		slot10 = slot0.uid
		slot11 = slot1.uid

		if slot0.stage ~= slot1.stage then
			return slot5 < slot4
		end

		if slot2 ~= slot3 then
			return slot3 < slot2
		end

		if slot6 ~= slot7 then
			return slot7 < slot6
		end

		if slot8 ~= slot9 then
			return slot9 < slot8
		end

		return slot11 < slot10
	end)

	return slot1
end

function slot0.GetEquipData(slot0)
	slot1 = {}
	slot2 = EquipData
	slot4 = slot2
	slot2 = slot2.GetEquipListComplex
	slot5 = slot0.params_.order or ItemConst.SORT_TYPE.DOWN
	slot6 = slot0.params_.priority or EquipConst.EQUIP_SORT.LEVEL
	slot7 = slot0.params_.suitPos or 0
	slot8 = slot0.params_.suit or 0
	slot9 = slot0.params_.skill or 0
	slot3 = HeroTools.GetEquipMap(HeroData:GetHeroList())

	for slot7, slot8 in pairs(slot2(slot4, slot5, slot6, slot7, slot8, slot9)) do
		slot9 = EquipData:GetEquipData(slot8)

		table.insert(slot1, {
			number = 1,
			type = ItemConst.ITEM_TYPE.EQUIP,
			id = slot9.prefab_id,
			equip_id = slot9.equip_id,
			equip_info = slot9,
			equip_lv = EquipTools.CountEquipLevel(slot9),
			equiping = {
				heroId = slot3[slot9.equip_id] ~= nil and slot3[slot9.equip_id] or 0
			}
		})
	end

	return slot1
end

function slot0.GetGiftData(slot0)
	slot1 = {}
	slot2 = 30011
	slot5 = MaterialData
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetMaterialListByTypes(slot7, {
		ItemConst.ITEM_TYPE.ARCHIVE_GIFT
	})) do
		if slot7.num > 0 then
			table.insert(slot1, {
				id = slot7.id,
				number = slot7.num,
				type = ItemConst.ITEM_TYPE.MATERIAL
			})
		end
	end

	if MaterialData:GetMaterial(slot2).num > 0 then
		table.insert(slot1, {
			id = slot2,
			type = ItemConst.ITEM_TYPE.MATERIAL,
			number = MaterialData:GetMaterial(slot2).num
		})
	end

	table.sort(slot1, function (slot0, slot1)
		slot2 = ItemCfg[slot0.id]
		slot3 = ItemCfg[slot1.id]

		if slot0.id == uv0 and slot1.id ~= uv0 or slot0.id ~= uv0 and slot1.id == uv0 then
			return math.abs(slot0.id - uv0) < math.abs(slot1.id - uv0)
		end

		if slot2.rare == slot3.rare then
			return slot3.id < slot2.id
		else
			return slot3.rare < slot2.rare
		end
	end)

	return slot1
end

function slot0.CheckExpiredList(slot0)
	if #MaterialData:CheckExpiredMaterialList() > 0 then
		JumpTools.OpenPageByJump("bagExpired", {
			materialList = slot1
		})
		MaterialAction.ReadExpiredMaterial()

		return true
	end

	return false
end

function slot0.UpdateSuitList(slot0)
	slot0.haveSuitList_ = {}

	for slot4, slot5 in pairs(EquipTools.GetHaveSuitList()) do
		if slot5 < EquipConst.EX_EQUIP_SUIT_ID then
			table.insert(slot0.haveSuitList_, slot5)
		end
	end
end

function slot0.UpdateSkillList(slot0)
	slot0.haveSkillList_ = EquipTools.GetHaveSkillList()
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == "material" then
		slot3 = 10601
	elseif slot1 == "heropiece" then
		slot3 = 10602
	elseif slot1 == "equip" then
		slot3 = 10603
	elseif slot1 == "gift" then
		slot3 = 10604
	end

	OperationRecorder.RecordStayView("STAY_VIEW_BAG", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
