slot0 = class("WeaponServantListView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantListUI"
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

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.btnCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "btnCon")
	slot0.watchCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "watch")
	slot0.headCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
	slot0.weaponServantList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, WeaponServantListItem)
	slot0.scaleImage_ = slot0:FindCom("UIScaleImage", "", slot0.roleTrs_)
	slot0.detailView_ = WeaponServantDetailView.New(slot0.detailGo_)

	slot0.detailView_:SetDescBtn(true)
	slot0.detailView_:SetLockBtn(true)
	slot0.detailView_:RegisterWatchFunc(function ()
		uv0:SetUIShow(false)

		uv0.scaleImage_.enabled = true
	end)

	slot0.avatarBtn_1Con_ = ControllerUtil.GetController(slot0.avatarbtn_1Btn_.transform, "avatarBtn_1")
	slot0.avatarBtn_2Con_ = ControllerUtil.GetController(slot0.avatarbtn_2Btn_.transform, "avatarBtn_2")
	slot0.dropdown_ = WeaponServantRaceDropdownView.New(slot0.dropdownGo_)

	slot0.dropdown_:SetCallback(handler(slot0, slot0.OnSelectRace))
end

function slot0.OnServantLock(slot0, slot1, slot2)
	slot0:InitData()
	slot0.weaponServantList_:Refresh()
end

function slot0.InitData(slot0)
	slot0.servantMap_ = ServantTools.GetServantMap()
	slot0.dataList_ = {}

	for slot5, slot6 in pairs(WeaponServantData:GetWeaponServantList()) do
		if not ServantTools.GetIsHide(slot6.id) then
			table.insert(slot0.dataList_, slot6)
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
		slot4 = slot0.stage
		slot5 = slot1.stage
		slot6 = WeaponServantCfg[slot0.id].race
		slot7 = WeaponServantCfg[slot1.id].race
		slot8 = slot0.id
		slot9 = slot1.id
		slot10 = slot0.uid
		slot11 = slot1.uid

		if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
			return slot3 < slot2
		end

		if slot4 ~= slot5 then
			return slot5 < slot4
		end

		if slot6 ~= slot7 then
			return slot7 < slot6
		end

		if slot8 ~= slot9 then
			return slot9 < slot8
		end

		return slot11 < slot10
	end)

	function slot6(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.raceList_, slot6)

	slot0.showList_ = {}

	for slot6, slot7 in ipairs(slot0.dataList_) do
		if slot0.curRace_ == nil or WeaponServantCfg[slot7.id].race == slot0.curRace_ then
			table.insert(slot0.showList_, slot7)
		end
	end

	slot0.dropdown_:SetRaceData(slot0.raceList_, slot0.raceCount_)

	if #slot0.showList_ > 0 then
		if slot0.currentData_ then
			slot3 = slot0.currentData_.uid

			if table.indexof(slot0.showList_, slot0.currentData_) then
				slot0.selectedIndex_ = slot4
				slot0.selectedUID_ = slot3
			else
				slot0.selectedIndex_ = 1
				slot0.selectedUID_ = slot0.showList_[1].uid
			end
		else
			slot0.selectedIndex_ = 1
			slot0.selectedUID_ = slot0.showList_[1].uid
		end
	end
end

function slot0.OnSelectRace(slot0, slot1)
	slot0:UpdateDataWithRace(slot1)
	slot0:UpdateView()

	if #slot0.showList_ > 0 then
		slot0:SelectItem(1, slot0.showList_[1].uid)
	end
end

function slot0.UpdateDataWithRace(slot0, slot1)
	if slot1 == 0 then
		slot0.curRace_ = nil
		slot0.showList_ = slot0.dataList_
	else
		slot0.curRace_ = slot1
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
		uid = slot3.uid,
		id = slot3.id,
		number = slot3.stage,
		index = slot1,
		equiping = {
			heroId = slot0.servantMap_[slot3.uid] or 0
		}
	})

	if slot0.selectedUID_ == slot3.uid then
		slot2:ShowSelect(1)
	else
		slot2:ShowSelect(0)
	end

	if slot3.locked == 1 then
		slot2:ShowLock(true)
	else
		slot2:ShowLock(false)
	end

	slot2:RegistCallBack(function ()
		uv0:SelectItem(uv1, uv2.uid)
	end)
end

function slot0.SelectItem(slot0, slot1, slot2)
	slot0.selectedIndex_ = slot1
	slot0.selectedUID_ = slot2

	slot0.weaponServantList_:Refresh()
	OperationRecorder.Record("WeaponServant", "selectItem")
	slot0:UpdateWeaponServantDetailView()
end

function slot0.UpdateWeaponServantDetailView(slot0)
	slot0.currentData_ = slot0.showList_[slot0.selectedIndex_]
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0.currentData_.id)

	slot0.detailView_:SetWeaponServantData(slot0.currentData_)

	slot2 = slot0.currentData_.stage
	slot4 = GameSetting.weapon_promote_max.value[WeaponServantCfg[slot0.currentData_.id].starlevel] + 1

	if WeaponServantCfg[slot0.currentData_.id].type == 3 then
		slot0.btnCon_:SetSelectedState("merge")
	else
		if slot4 <= slot2 then
			slot0.btnCon_:SetSelectedState("max")
		else
			slot0.btnCon_:SetSelectedState("normal")
		end

		slot0.detailView_:SetLockBtn(true)
	end

	SetActive(slot0.btncontainGo_, true)
	slot0.avatarBtn_1Con_:SetSelectedState("off")
	slot0.avatarBtn_2Con_:SetSelectedState("on")

	if ServantTools.GetSleepyServantByServant(slot0.currentData_.id) then
		slot0.headCon_:SetSelectedState("true")
		slot0:RefreshSleepyIcon(slot5, slot0.currentData_.id)
	else
		slot0.headCon_:SetSelectedState("false")
	end
end

function slot0.RefreshSleepyIcon(slot0, slot1, slot2)
	slot0.servanticon_1Img_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Icon438x238/" .. slot1)
	slot0.servanticon_2Img_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Icon438x238/" .. slot2)

	CommonTools.Convert2SamePosition(slot0.avataTrs_, slot0.avataposTrs_)
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.scaleImage_, function ()
		uv0:SetUIShow(true)
		uv0.scaleImage_:ResetContent()

		uv0.scaleImage_.enabled = false
	end)
	slot0:AddBtnListener(slot0.detailBtn_, nil, function ()
		if uv0.currentData_ then
			if WeaponServantCfg[uv0.currentData_.id].type == 3 then
				uv0:Go("/showServantView", {
					look = true,
					state = "onlydetail",
					id = uv0.currentData_.id
				})
			else
				uv0:Go("/weaponServant", {
					state = "detail",
					uid = uv0.currentData_.uid
				})
			end
		end
	end)
	slot0:AddBtnListener(slot0.promotebtnBtn_, nil, function ()
		uv0:Go("/weaponServant", {
			state = "strength",
			uid = uv0.currentData_.uid
		})
	end)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		uv0:Go("/weaponServantMerge", {
			race = WeaponServantCfg[uv0.currentData_.id].race,
			costUid = uv0.currentData_.uid
		})
	end)
	slot0:AddBtnListener(slot0.resolvebtnBtn_, nil, function ()
		uv0:Go("/weaponServantDecomposeView", {
			race = uv0.curRace_
		})
	end)
	slot0:AddBtnListener(slot0.avatarbtn_1Btn_, nil, function ()
		SetActive(uv0.btncontainGo_, false)
		uv0.avatarBtn_1Con_:SetSelectedState("on")
		uv0.avatarBtn_2Con_:SetSelectedState("off")

		slot0 = ServantTools.GetSleepyServantByServant(uv0.currentData_.id)
		uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0)

		uv0.detailView_:RefreshToSleepyServant(slot0)
	end)
	slot0:AddBtnListener(slot0.avatarbtn_2Btn_, nil, function ()
		SetActive(uv0.btncontainGo_, true)
		uv0.avatarBtn_1Con_:SetSelectedState("off")
		uv0.avatarBtn_2Con_:SetSelectedState("on")

		uv0.icon_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. uv0.currentData_.id)

		uv0.detailView_:SetWeaponServantData(uv0.currentData_)
	end)
end

function slot0.UpdateView(slot0)
	if #slot0.showList_ <= 0 then
		slot0.emptyController_:SetSelectedState("true")
	else
		slot0.emptyController_:SetSelectedState("false")

		slot0.haveText_.text = #slot0.dataList_ .. "/" .. GameSetting.max_weapon_servant.value[1]

		slot0.weaponServantList_:StartScroll(#slot0.showList_, slot0.selectedIndex_)
	end
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
		uv0.currentData_ = nil
		uv0.selectedIndex_ = nil
		uv0.curRace_ = nil

		uv0.dropdown_:Reset()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()
	slot0:InitData()

	if slot0.params_.uid then
		for slot4, slot5 in pairs(slot0.showList_) do
			if slot0.params_.uid == slot5.uid then
				slot0.selectedIndex_ = slot4
				slot0.selectedUID_ = slot5.uid

				break
			end
		end
	end

	slot0:UpdateView()

	if #slot0.showList_ <= 0 then
		return
	end

	if slot0.detailView_ then
		slot0.detailView_:OnEnter()
	end

	if slot0.selectedUID_ then
		slot0:UpdateWeaponServantDetailView()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.detailView_ then
		slot0.detailView_:OnExit()
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.currentData_ = nil
	slot0.selectedIndex_ = nil
	slot0.curRace_ = nil

	slot0.dropdown_:Reset()
end

function slot0.SetUIShow(slot0, slot1)
	if slot1 then
		slot0:ShowDefaultBar()
		manager.windowBar:RegistBackCallBack(function ()
			uv0.currentData_ = nil
			uv0.selectedIndex_ = nil
			uv0.curRace_ = nil

			uv0.dropdown_:Reset()
			JumpTools.Back()
		end)
		slot0.watchCon_:SetSelectedState("show")
	else
		manager.windowBar:HideBar()
		slot0.watchCon_:SetSelectedState("notShow")
	end
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
