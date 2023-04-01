slot0 = class("WeaponServantShowView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantMergeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectingRace_ = false

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mergeEnableController_ = ControllerUtil.GetController(slot0.mergeBtn_.gameObject.transform, "enabled")
	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.isShowController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isshow")
	slot0.weaponServantList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, WeaponServantListItem)
	slot0.detailView_ = WeaponServantDetailView.New(slot0.detailGo_)

	slot0.detailView_:SetDescBtn(true)
	slot0.detailView_:SetLockBtn(false)

	slot0.dropdown_ = WeaponServantRaceDropdownView.New(slot0.dropdownGo_)

	slot0.dropdown_:SetCallback(handler(slot0, slot0.OnSelectRace))
end

function slot0.InitData(slot0)
	slot0.dataList_ = {}

	for slot5, slot6 in ipairs(WeaponServantData:GetAllPrivateWeaponServantIdList()) do
		if not ServantTools.GetIsHide(slot6) then
			table.insert(slot0.dataList_, {
				locked = 0,
				stage = 1,
				uid = 0,
				id = slot6
			})
		end
	end

	slot0.raceList_ = {}
	slot0.raceCount_ = {
		[0] = #slot0.dataList_
	}

	for slot5, slot6 in pairs(slot0.dataList_) do
		if not table.indexof(slot0.raceList_, WeaponServantCfg[slot6.id].race) then
			table.insert(slot0.raceList_, slot7)
		end

		if not slot0.raceCount_[slot7] then
			slot0.raceCount_[slot7] = 0
		end

		slot0.raceCount_[slot7] = slot0.raceCount_[slot7] + 1
	end

	table.sort(slot0.dataList_, function (slot0, slot1)
		slot6 = slot0.id
		slot7 = slot1.id

		if (uv0:MaterialEnoughById(slot0.id) and 1 or 0) ~= (uv0:MaterialEnoughById(slot1.id) and 1 or 0) then
			return slot5 < slot3
		end

		return slot6 < slot7
	end)
	table.sort(slot0.raceList_, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot0.showList_ = slot0.dataList_

	slot0.dropdown_:SetRaceData(slot0.raceList_, slot0.raceCount_)
end

function slot0.FindCurrentData(slot0)
	if #slot0.showList_ > 0 then
		if slot0.currentData_ then
			slot1 = slot0.currentData_.id

			if (function (slot0, slot1)
				for slot5, slot6 in ipairs(slot0) do
					if slot6.id == slot1.id then
						return slot5
					end
				end

				return false
			end)(slot0.showList_, slot0.currentData_) then
				slot0.selectedIndex_ = slot3
				slot0.selectedId_ = slot1
			else
				slot0.selectedIndex_ = 1
				slot0.selectedId_ = slot0.showList_[1].id
			end
		else
			slot0.selectedIndex_ = 1
			slot0.selectedId_ = slot0.showList_[1].id
		end
	end
end

function slot0.OnSelectRace(slot0, slot1, slot2)
	slot0.selectingRace_ = slot1

	slot0:UpdateDataWithRace(slot1)
	slot0:UpdateView()

	if #slot0.showList_ > 0 then
		slot0:SelectItem(1, slot0.showList_[1].id)
	end
end

function slot0.UpdateDataWithRace(slot0, slot1)
	if slot1 == 0 then
		slot0.showList_ = slot0.dataList_
	else
		slot0.showList_ = {}

		for slot5, slot6 in ipairs(slot0.dataList_) do
			if WeaponServantCfg[slot6.id].race == slot1 then
				table.insert(slot0.showList_, slot6)
			end
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.showList_[slot1]

	slot2:RefreshData({
		isEquip = true,
		id = slot3.id,
		number = slot3.stage,
		index = slot1
	})

	if slot0.selectedId_ == slot3.id then
		slot2:ShowSelect(1)
	else
		slot2:ShowSelect(0)
	end

	slot2:ShowMask(false)
	slot2:RegistCallBack(function ()
		uv0:SelectItem(uv1, uv2.id)
	end)
end

function slot0.SelectItem(slot0, slot1, slot2)
	slot0.selectedIndex_ = slot1
	slot0.selectedId_ = slot2

	slot0.weaponServantList_:Refresh()
	OperationRecorder.Record("WeaponServant", "selectItem")
	slot0:UpdateWeaponServantDetailView()
end

function slot0.UpdateWeaponServantDetailView(slot0)
	slot0.currentData_ = slot0.showList_[slot0.selectedIndex_]
	slot0.weaponServantCfg_ = WeaponServantCfg[slot0.currentData_.id]
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0.currentData_.id)

	slot0.detailView_:SetWeaponServantData(slot0.currentData_)
	slot0.detailView_:SetLookBtn(false)
	slot0:UpdateCost()
end

function slot0.UpdateCost(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot6[1] == slot0.weaponServantCfg_.race then
			slot1 = slot6[2]
		end
	end

	slot3 = 0

	if WeaponServantData:GetWeaponServantById(slot1[1][1]) then
		slot3 = #slot2
	end

	slot5 = 0

	if CurrencyData:GetCurrencyMap()[slot1[2][1]] then
		slot5 = slot4.num
	end

	slot6 = tostring(slot3)

	if slot3 < slot1[1][2] then
		slot6 = "<color='#FF0000'>" .. slot6 .. "</color>"
	end

	slot6 = slot6 .. "/" .. tostring(slot1[1][2])
	slot7 = tostring(slot1[2][2])

	if slot5 < slot1[2][2] then
		slot7 = "<color='#FF0000'>" .. tostring(slot1[2][2]) .. "</color>"
	end

	slot0.costmoneyText_.text = slot7

	if slot1[1][2] <= slot3 and slot1[2][2] <= slot5 then
		slot0.mergeEnableController_:SetSelectedState("true")
	else
		slot0.mergeEnableController_:SetSelectedState("false")
	end
end

function slot0.MaterialEnough2(slot0, slot1)
	slot2 = WeaponServantCfg[slot1]
	slot3 = {}

	for slot7, slot8 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot8[1] == slot2.race then
			slot3 = slot8[2]
		end
	end

	slot5 = 0

	if WeaponServantData:GetWeaponServantById(slot3[1][1]) then
		slot5 = #slot4
	end

	slot7 = 0

	if CurrencyData:GetCurrencyMap()[slot3[2][1]] then
		slot7 = slot6.num
	end

	return slot3[1][2] <= slot5, slot3[2][2] <= slot7
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		slot0, slot1 = uv0:MaterialEnough2(uv0.currentData_.id)

		if not slot0 then
			ShowTips("SERVANT_MERGE_MATERIAL_NOT_ENOUGH")

			return
		end

		if not slot1 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_GOLD")

			return
		end

		if uv0.costUid_ then
			uv0:Go("/weaponServantWakeUp", {
				backThrice = true,
				servantID = uv0.currentData_.id,
				uid = uv0.costUid_
			})

			return
		end

		slot2 = {}

		for slot6, slot7 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
			if slot7[1] == uv0.weaponServantCfg_.race then
				slot2 = slot7[2]
			end
		end

		slot3 = WeaponServantData:GetWeaponServantById(slot2[1][1])

		table.sort(slot3, function (slot0, slot1)
			if slot0.locked ~= slot1.locked then
				return slot0.locked < slot1.locked
			end

			return slot0.uid < slot1.uid
		end)

		slot7 = slot3[1].uid
		slot8 = ItemCfg[slot3[1].id].name

		if slot3[1].locked == 1 then
			slot9 = nil

			if slot5 then
				slot9 = string.format(GetTips("SERVANT_MATERIAL_LOCKED"), slot8)
			end

			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = slot9,
				OkCallback = function ()
					uv0.costUid_ = uv1

					uv0:Go("/weaponServantWakeUp", {
						servantID = uv0.currentData_.id,
						uid = uv1
					})
				end,
				CancelCallback = function ()
				end
			})
		else
			uv0.costUid_ = slot7

			uv0:Go("/weaponServantWakeUp", {
				servantID = uv0.currentData_.id,
				uid = slot7
			})
		end
	end)
end

function slot0.UpdateView(slot0)
	if #slot0.showList_ <= 0 then
		slot0.emptyController_:SetSelectedState("true")
	else
		slot0.emptyController_:SetSelectedState("false")
		slot0.weaponServantList_:StartScroll(#slot0.showList_)
	end
end

function slot0.MaterialEnough(slot0)
	return slot0:MaterialEnoughById(slot0.currentData_.id)
end

function slot0.MaterialEnoughById(slot0, slot1)
	slot2 = WeaponServantCfg[slot1]
	slot3 = {}

	for slot7, slot8 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot8[1] == slot2.race then
			slot3 = slot8[2]
		end
	end

	slot5 = 0

	if WeaponServantData:GetWeaponServantById(slot3[1][1]) then
		slot5 = #slot4
	end

	slot7 = 0

	if CurrencyData:GetCurrencyMap()[slot3[2][1]] then
		slot7 = slot6.num
	end

	return slot3[2][2] <= slot7 and slot3[1][2] <= slot5
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
		JumpTools.Back(1, {
			uid = WeaponServantData:GetServantMergeMap(uv0.costUid_)
		})

		uv0.currentData_ = nil
		uv0.selectedIndex_ = nil
		uv0.selectingRace_ = nil
	end)
end

function slot0.OnWeaponServantListUpdate(slot0)
	slot0:UpdateCost()
end

function slot0.OnMaterialUpdate(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if slot7[1] == slot0.weaponServantCfg_.race then
			slot2 = slot7[2]
		end
	end

	if slot1 == slot2[2][1] then
		slot0:UpdateCost()
	end
end

function slot0.GetRaceSetting(slot0, slot1)
	if slot1 ~= 0 then
		return table.indexof(RaceEffectCfg.all, slot1) + 1
	else
		return 1
	end
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()
	slot0:InitData()

	if slot0.params_.race then
		slot0.selectingRace_ = slot0.params_.race
	end

	slot0.costUid_ = slot0.params_.costUid

	if slot0.detailView_ then
		slot0.detailView_:OnEnter()
	end

	if slot0.params_.isShow then
		slot0.isShowController_:SetSelectedState("true")
	else
		slot0.isShowController_:SetSelectedState("false")
	end

	if slot0.selectingRace_ then
		slot0.dropdown_:SelectRaceWithoutCallback(slot0:GetRaceSetting(slot0.selectingRace_))
		slot0:UpdateDataWithRace(slot0.selectingRace_)
	end

	if slot0.params_.servantID then
		slot0.currentData_ = {
			id = slot0.params_.servantID
		}
	end

	slot0:FindCurrentData()
	slot0:UpdateView()

	if slot0.selectedId_ then
		slot0:UpdateWeaponServantDetailView()
	end

	slot0.materialUpdateHandler_ = handler(slot0, slot0.OnMaterialUpdate)

	manager.notify:RegistListener(MATERIAL_MODIFY, slot0.materialUpdateHandler_)

	slot0.weaponServantListUpdateHandler_ = handler(slot0, slot0.OnWeaponServantListUpdate)

	manager.notify:RegistListener(WEAPON_SERVANT_LIST_UPDATE, slot0.weaponServantListUpdateHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(MATERIAL_MODIFY, slot0.materialUpdateHandler_)

	slot0.materialUpdateHandler_ = nil

	manager.notify:RemoveListener(WEAPON_SERVANT_LIST_UPDATE, slot0.weaponServantListUpdateHandler_)

	slot0.weaponServantListUpdateHandler_ = nil

	manager.windowBar:HideBar()

	if slot0.detailView_ then
		slot0.detailView_:OnExit()
	end

	slot0.dropdown_:Reset()
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.currentData_ = nil
	slot0.selectedIndex_ = nil
end

function slot0.Dispose(slot0)
	if slot0.weaponServantList_ then
		slot0.weaponServantList_:Dispose()

		slot0.weaponServantList_ = nil
	end

	if slot0.dropdown_ then
		slot0.dropdown_:Dispose()

		slot0.dropdown_ = nil
	end

	if slot0.detailView_ then
		slot0.detailView_:Dispose()

		slot0.detailView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
