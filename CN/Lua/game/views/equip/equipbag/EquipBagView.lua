slot0 = class("EquipBagView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot4

	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.handler_ = slot1

	for slot6, slot7 in pairs(slot2) do
		slot0.info_[slot6] = slot7
	end

	slot0:RefreshSuitPos()
	slot0:RefreshSkillPos()
	slot0:Render()
end

function slot0.RefreshKey(slot0, slot1, slot2)
	slot0.info_[slot1] = slot2
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItem)
	slot0.suitScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSuitItem), slot0.suitListGo_, EquipBagSuitItem)
	slot0.suitDetailScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSuitDetailItem), slot0.suitDetailListGo_, EquipBagSuitDetailItem)
	slot0.skillScrollHelper_ = LuaList.New(handler(slot0, slot0.indexSkillItem), slot0.skillListGo_, SkillSelectItem)
	slot0.dropDown_ = slot0.selectDropGo_:GetComponent("Dropdown")
	slot0.suitCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "suit")
	slot0.orderController_ = ControllerUtil.GetController(slot0.sortBtn_.transform, "order")
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetSelectType("common")

	slot3 = slot0.equipList_[slot1]

	slot2:RefreshData(slot3)
	slot2:ShowEquiping(slot3.equipHeroId ~= nil, slot3.equipHeroId)
	slot2:RegistCallBack(function (slot0)
		uv0.handler_:ClickBagItem(slot0)
	end)
	slot2:ShowSelect(slot0.selectId_ == slot3.equip_id)
end

function slot0.InitSuitList(slot0)
	slot1 = {}
	slot2 = EquipRecommendCfg[slot0.info_.heroId] and EquipRecommendCfg[slot0.info_.heroId].suit_list or {}
	slot0.suitList_, slot1 = EquipTools.GetHaveSuitList(true)

	table.sort(slot0.suitList_, function (slot0, slot1)
		slot2 = not not table.indexof(uv0, slot0)
		slot3 = not not table.indexof(uv0, slot1)

		if uv1[slot0] ~= uv1[slot1] then
			if slot2 == slot3 then
				return not uv1[slot1]
			else
				return not slot3
			end
		elseif slot2 == slot3 then
			return slot0 < slot1
		else
			return not slot3
		end
	end)

	slot0.suitDetailList_ = deepClone(slot0.suitList_)

	table.insert(slot0.suitList_, 1, "recommend")
	table.insert(slot0.suitList_, 1, 0)
	slot0.suitScrollHelper_:StartScroll(#slot0.suitList_, 1)
	slot0.suitDetailScrollHelper_:StartScroll(#slot0.suitDetailList_, 1)
end

function slot0.indexSuitItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.info_.heroId, slot0.suitList_[slot1])
	slot2:RefreshPos(slot0.info_.suitPos)
	slot2:RegistCallBack(function (slot0, slot1)
		uv0.suitShow_ = true

		uv0:SelectSuit(slot0, slot1)
	end)
end

function slot0.indexSuitDetailItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.info_.heroId, slot0.suitDetailList_[slot1])
	slot2:RefreshPos(slot0.info_.suitPos)
	slot2:RegistCallBack(function (slot0, slot1)
		uv0.suitShow_ = true

		uv0:SelectSuit(slot0, slot1)
	end)
end

function slot0.SelectSuit(slot0, slot1, slot2)
	slot0.info_.skill = 0

	SetActive(slot0.skillListGo_, false)
	SetActive(slot0.suitListGo_, false)
	SetActive(slot0.suitDetailListGo_, false)
	SetActive(slot0.listGo_, true)
	SetActive(slot0.switchPosGo_, true)
	SetActive(slot0.switchGo_, false)
	SetActive(slot0.suitBtnGo_, true)
	SetActive(slot0.skillBtnGo_, false)

	if slot1 == "recommend" then
		slot0.info_.suit = slot2
		slot0.suitBtnText_.text = GetTips("TIP_RECOMMEND")
	else
		slot0.info_.suit = slot1
		slot0.suitBtnText_.text = slot1 == 0 and GetTips("ALL") or EquipSuitCfg[slot1].name
	end

	slot0:Render()
end

function slot0.InitSkillList(slot0)
	slot0.skillList_ = EquipTools.GetHaveSkillList(true)

	table.insert(slot0.skillList_, 1, 0)
	slot0.skillScrollHelper_:StartScroll(#slot0.skillList_, 1)
end

function slot0.indexSkillItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0, {
		id = slot0.skillList_[slot1]
	})
	slot2:RefreshPos(slot0.info_.suitPos)
	slot2:RegistCallBack(function (slot0)
		uv0.info_.skill = slot0.id
		uv0.skillShow_ = true

		SetActive(uv0.skillListGo_, false)
		SetActive(uv0.listGo_, true)
		SetActive(uv0.switchPosGo_, true)
		SetActive(uv0.switchGo_, false)
		SetActive(uv0.skillBtnGo_, true)

		if slot0.id ~= 0 then
			uv0.skillBtnText_.text = EquipSkillCfg[slot0.id].name
		else
			uv0.skillBtnText_.text = GetTips("ALL")
		end

		uv0:Render()
	end)
end

function slot0.RefreshSuitPos(slot0)
	slot1 = slot0.info_.suitPos

	if slot0.suitScrollHelper_ then
		slot4 = slot0.suitScrollHelper_
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
			slot6:RefreshPos(slot1)
		end
	end
end

function slot0.RefreshSkillPos(slot0)
	slot1 = slot0.info_.suitPos

	if slot0.skillScrollHelper_ then
		slot4 = slot0.skillScrollHelper_
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
			slot6:RefreshPos(slot1)
		end
	end
end

function slot0.RefreshSelectStatus(slot0, slot1)
	if slot0.selectId_ == slot1 then
		return
	end

	slot0.selectId_ = slot1

	if slot0.scrollHelper_ then
		slot4 = slot0.scrollHelper_
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
			slot6:ShowSelect(slot1 == slot6:GetItemInfo().equip_id)
		end
	end
end

function slot0.RefreshEquipLock(slot0, slot1, slot2)
	if slot0.scrollHelper_ then
		slot5 = slot0.scrollHelper_
		slot7 = slot5

		for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
			if slot7:GetItemInfo().equip_id == slot2 then
				slot7:ShowLock(slot1)
			end
		end
	end
end

function slot0.Render(slot0)
	slot0:RefreshEquipList()
	slot0:RefreshState()
end

function slot0.AddUIListener(slot0)
	slot0.typeNameS_ = {
		"pos",
		"suit",
		"skill"
	}
	slot0.toggle_ = {}

	for slot4, slot5 in pairs(slot0.typeNameS_) do
		slot0.toggle_[slot5] = slot0[slot5 .. "Tgl_"]

		slot0:AddBtnListener(slot0.toggle_[slot5], nil, function ()
			if uv0 ~= uv1.selectType_ then
				uv1:ChangeShowView(uv0)

				if uv0 == "pos" then
					uv1:Render()
				elseif uv0 == "suit" then
					uv1:RefreshState()
					uv1:RefreshSuitPos()
				elseif uv0 == "skill" then
					uv1:RefreshState()
					uv1:RefreshSkillPos()
				end
			end
		end)
	end

	slot0.posToggle_ = {}

	for slot4 = 1, 6 do
		slot0.posToggle_[slot4] = slot0[slot4 .. "Tgl_"]

		slot0:AddBtnListener(slot0.posToggle_[slot4], nil, function ()
			if uv0 ~= uv1.info_.suitPos then
				uv1.handler_:SelectItem(nil, uv0)
				uv1:Render()
			elseif uv1.selectType_ ~= "pos" then
				uv1.handler_:SelectItem(nil, 0)
				uv1:Render()
			end
		end)
	end

	slot0:AddBtnListener(slot0.suitBtn_, nil, function ()
		SetActive(uv0.listGo_, false)
		SetActive(uv0.switchGo_, true)

		uv0.suitShow_ = false

		SetActive(uv0.dropDown_.gameObject, false)

		slot0 = uv0.info_.suitType_ == ItemConst.SUIT_TYPE.SMALL

		SetActive(uv0.suitListGo_, slot0)
		SetActive(uv0.suitDetailListGo_, not slot0)
		uv0:InitSuitList()
		uv0.suitScrollHelper_:StartScroll(#uv0.suitList_, 1)
		uv0.suitDetailScrollHelper_:StartScroll(#uv0.suitDetailList_, 1)
		uv0.suitCon_:SetSelectedState(uv0.info_.suitType_ == ItemConst.SUIT_TYPE.SMALL and "small" or "detail")
		SetActive(uv0.suitBtnGo_, false)
		SetActive(uv0.switchPosGo_, false)
		uv0.handler_:SelectItem(nil, 0)
		uv0:RefreshSuitPos()
	end)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		SetActive(uv0.listGo_, false)
		SetActive(uv0.switchGo_, true)

		uv0.skillShow_ = false

		SetActive(uv0.skillListGo_, true)
		uv0.skillScrollHelper_:StartScroll(#uv0.skillList_, 1)
		SetActive(uv0.skillBtnGo_, false)
		SetActive(uv0.switchPosGo_, false)
		uv0.handler_:SelectItem(nil, 0)
		uv0:RefreshSkillPos()
		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		if uv0.info_.order == ItemConst.SORT_TYPE.DOWN then
			uv0.info_.order = ItemConst.SORT_TYPE.UP
		else
			uv0.info_.order = ItemConst.SORT_TYPE.DOWN
		end

		uv0.isNeedAnimat_ = true

		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.suitTypeBtn_, nil, function ()
		if uv0.info_.suitType_ == ItemConst.SUIT_TYPE.SMALL then
			uv0.info_.suitType_ = ItemConst.SUIT_TYPE.DETAIL
		else
			uv0.info_.suitType_ = ItemConst.SUIT_TYPE.SMALL
		end

		uv0:ChangeShowView("suit")

		uv0.isNeedAnimat_ = true

		uv0:Render()
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		if uv0.info_ == nil then
			return
		end

		if slot0 == 0 then
			uv0.info_.priority = EquipConst.EQUIP_SORT.LEVEL

			OperationRecorder.Record("hero", "heroEquipSortLevel")
		else
			uv0.info_.priority = EquipConst.EQUIP_SORT.RARE

			OperationRecorder.Record("hero", "heroEquipSortRare")
		end

		uv0:Render()
	end)
end

function slot0.ChangeShowView(slot0, slot1)
	slot0.selectType_ = slot1

	if slot1 == "pos" then
		SetActive(slot0.listGo_, true)
		SetActive(slot0.switchPosGo_, true)
		SetActive(slot0.skillListGo_, false)
		SetActive(slot0.suitListGo_, false)
		SetActive(slot0.suitDetailListGo_, false)
		SetActive(slot0.switchGo_, true)
		SetActive(slot0.suitBtnGo_, false)
		SetActive(slot0.skillBtnGo_, false)

		slot0.info_.skill = 0
		slot0.info_.suit = 0

		if slot0.info_.suitPos == 0 then
			slot0.handler_:SelectItem(nil, 1)
		end
	elseif slot1 == "suit" then
		SetActive(slot0.listGo_, false)
		SetActive(slot0.switchPosGo_, false)
		SetActive(slot0.skillListGo_, false)

		slot2 = slot0.info_.suitType_ == ItemConst.SUIT_TYPE.SMALL

		SetActive(slot0.suitListGo_, slot2)
		SetActive(slot0.suitDetailListGo_, not slot2)
		slot0.suitScrollHelper_:StartScroll(#slot0.suitList_, 1)
		slot0.suitDetailScrollHelper_:StartScroll(#slot0.suitDetailList_, 1)

		slot0.info_.suitPos = 0
		slot0.info_.skill = 0

		slot0.handler_:SelectItem(nil, 0)
	elseif slot1 == "skill" then
		SetActive(slot0.listGo_, false)
		SetActive(slot0.switchPosGo_, false)
		SetActive(slot0.skillListGo_, true)
		slot0.skillScrollHelper_:StartScroll(#slot0.skillList_, 1)
		SetActive(slot0.suitListGo_, false)
		SetActive(slot0.suitDetailListGo_, false)

		slot0.info_.suitPos = 0
		slot0.info_.suit = 0

		slot0.handler_:SelectItem(nil, 0)
	end
end

function slot0.RefreshListEquipData(slot0)
	slot1 = HeroData:GetEquipMap()

	for slot5, slot6 in ipairs(slot0.equipList_) do
		slot6.equipHeroId = slot1[slot6.equip_id]
	end
end

function slot0.RefreshEquipS(slot0)
	slot2 = HeroData:GetEquipMap()

	for slot6, slot7 in pairs(slot0.scrollHelper_:GetItemList()) do
		slot8 = slot7:GetItemInfo()

		if slot8.equipHeroId ~= slot2[slot8.equip_id] then
			slot8.equipHeroId = slot2[slot8.equip_id]

			slot7:RefreshData(slot8)
			slot7:ShowEquiping(slot8.equipHeroId ~= nil, slot8.equipHeroId)
		end
	end

	slot0:RefreshListEquipData()
end

function slot0.GetEquipList(slot0)
	slot1 = EquipData:GetEquipListComplex(slot0.info_.order, slot0.info_.priority, slot0.info_.suitPos, slot0.info_.suit, slot0.info_.skill)

	if slot0.info_.hideIdList then
		for slot5 = #slot1, 1, -1 do
			if table.keyof(hideIdList, slot1[slot5]) then
				table.remove(slot1, slot5)
			end
		end
	end

	slot2 = HeroData:GetEquipMap()
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = EquipData:GetEquipData(slot8)

		table.insert(slot3, {
			number = 1,
			type = ItemCfg[slot9.prefab_id].type,
			id = slot9.prefab_id,
			equip_id = slot9.equip_id,
			equip_info = slot9,
			equip_star = getItemStar(slot9.prefab_id),
			equip_lv = EquipTools.CountEquipLevel(slot9),
			equipHeroId = slot2[slot8]
		})
	end

	return slot3
end

function slot0.RefreshEquipList(slot0)
	if slot0.listGo_.activeSelf == false then
		return
	end

	slot0.equipList_ = slot0:GetEquipList()

	if slot0.isNeedAnimat_ then
		if slot0.lastPosition_ ~= nil then
			slot0.scrollHelper_:StartScrollByPosition(#slot0.equipList_, slot0.lastPosition_)

			slot0.lastPosition_ = nil
		else
			slot0.scrollHelper_:StartScroll(#slot0.equipList_, 1)
		end

		slot0.isNeedAnimat_ = false
	elseif slot0.lastPosition_ ~= nil then
		slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0.equipList_, slot0.lastPosition_)

		slot0.lastPosition_ = nil
	else
		slot0.scrollHelper_:StartScrollWithoutAnimator(#slot0.equipList_)
	end
end

function slot0.RefreshState(slot0)
	for slot4, slot5 in pairs(slot0.typeNameS_) do
		slot6 = slot5 == slot0.selectType_

		SetActive(slot0[slot5 .. "UnSelectGo_"], not slot6)
		SetActive(slot0[slot5 .. "SelectGo_"], slot6)
	end

	for slot4 = 1, 6 do
		slot5 = slot4 == slot0.info_.suitPos

		SetActive(slot0[slot4 .. "UnSelectGo_"], not slot5)
		SetActive(slot0[slot4 .. "SelectGo_"], slot5)
	end

	if slot0.suitShow_ or slot0.selectType_ == "pos" then
		SetActive(slot0.dropDown_.gameObject, true)
		SetActive(slot0.contentGo_, true)
		slot0.orderController_:SetSelectedState(slot0.info_.order == ItemConst.SORT_TYPE.DOWN and "desc" or "asc")
		slot0.suitCon_:SetSelectedState("not_suit")
	elseif slot0.selectType_ == "skill" then
		SetActive(slot0.dropDown_.gameObject, slot0.skillShow_)
		SetActive(slot0.contentGo_, slot0.skillShow_)
		slot0.orderController_:SetSelectedState(slot0.info_.order == ItemConst.SORT_TYPE.DOWN and "desc" or "asc")
		slot0.suitCon_:SetSelectedState("not_suit")
	else
		SetActive(slot0.dropDown_.gameObject, false)
		SetActive(slot0.contentGo_, true)
		slot0.suitCon_:SetSelectedState(slot0.info_.suitType_ == ItemConst.SUIT_TYPE.SMALL and "small" or "detail")
	end

	slot0.dropDown_.value = slot0.info_.priority == EquipConst.EQUIP_SORT.LEVEL and 0 or 1
end

function slot0.ClearScrollPos(slot0)
	slot0.lastPosition_ = nil
end

function slot0.GetSelectType(slot0)
	return slot0.selectType_
end

function slot0.OnEnter(slot0, slot1)
	slot0.suitShow_ = false

	if slot0.selectType_ == nil then
		slot0.isNeedAnimat_ = true
		slot0.info_ = slot0.info_ or {}
		slot1 = slot1 or {}
		slot0.info_.suitType_ = slot1.suitType_ or ItemConst.SUIT_TYPE.SMALL
		slot0.info_.order = slot1.order or ItemConst.SORT_TYPE.DOWN
		slot0.info_.priority = slot1.priority or EquipConst.EQUIP_SORT.LEVEL
		slot0.info_.suitPos = slot1.suitPos or 0
		slot0.info_.hideIdList = slot1.hideIdList or {}
		slot0.info_.heroId = slot1.heroId or 0
		slot0.info_.skill = slot1.skill or 0

		slot0:ChangeShowView("pos")
		slot0:Render()
		slot0:InitSuitList()
		slot0:InitSkillList()
	else
		slot0:Render()
	end
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
	slot0.selectId_ = nil
	slot0.lastPosition_ = slot0.scrollHelper_:GetScrolledPosition()
end

function slot0.OnMainHomeViewTop(slot0)
	slot0:RefreshSelectStatus(0)

	slot0.selectType_ = nil
	slot0.info_ = nil
	slot0.dropDown_.value = 0
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0.suitScrollHelper_:Dispose()
	slot0.skillScrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
