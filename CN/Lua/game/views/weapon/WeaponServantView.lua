slot0 = class("WeaponServantView", ReduxView)
slot1 = "CD421E"
slot2 = "363A42"
slot3 = {
	"detail",
	"strength",
	"story",
	"replace"
}

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnEnter(slot0)
	slot0.inSleepyPage_ = false
	slot0.dataList_ = WeaponServantData:GetWeaponServantList()
	slot0.leftTogglegroup_.allowSwitchOff = false
	slot0.viewStack_ = {}
	slot0.servantMap_ = ServantTools.GetServantMap()

	if not slot0.params_.id then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.viewState_ == "strengthSelect" then
			uv0:RefreshUI("strength")

			return
		end

		if #uv0.viewStack_ > 0 then
			if uv0.viewStack_[#uv0.viewStack_].name == "replace" then
				uv0.pageController_:SetSelectedState("replace")

				uv0.viewState_ = "replace"
				uv0.mainServant_ = slot0.servant
				uv0.inSleepyPage_ = false

				uv0:RefreshReplaceScroll(slot0.uid)
				uv0:RefreshDetail(uv0.sortedList_[uv0.replaceSelectedItem_], true)
				uv0:RefreshServantIcon(uv0.sortedList_[uv0.replaceSelectedItem_].id)
			end

			uv0.viewStack_[#uv0.viewStack_] = nil
		else
			uv0:Back()
		end
	end)

	slot0.HeroID_ = nil

	if slot0.params_ then
		if slot0.params_.HeroID then
			slot0.HeroID_ = slot0.params_.HeroID
			slot0.mainServant_ = HeroTools.GetHeroServantInfo(slot0.HeroID_)
		elseif slot0.params_.uid then
			slot0.mainServant_ = WeaponServantData:GetServantDataByUID(slot0.params_.uid)
		elseif slot0.params_.id then
			slot0.mainServant_ = {
				uid = 0,
				locked = 0,
				id = slot0.params_.id,
				stage = slot0.params_.stage or 1
			}
		end

		slot0:RefreshUI(slot0.params_.state)

		if slot0.params_.state == "onlydetail" or slot0.params_.state == "onlystory" then
			slot0.detailView_:SetLockBtn(false)

			if slot0.params_.look then
				slot0.detailView_:SetLookBtn(true)
			else
				slot0.detailView_:SetLookBtn(false)
			end
		else
			slot0.detailView_:SetLockBtn(true)
			slot0.detailView_:SetLookBtn(true)
		end
	else
		slot0:RefreshUI("detail")
	end

	slot0.detailView_:OnEnter()
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.leftTogglegroup_.allowSwitchOff = true
	slot0.strengthSelectedItem_ = 0
	slot0.replaceSelectedItem_ = 0

	slot0:RemoveAllEventListener()

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.isTalkCD_ = nil

	slot0.detailView_:OnExit()

	slot1 = slot0:GetStayTime()

	if slot0.viewState_ == "replace" then
		OperationRecorder.RecordStayView("STAY_VIEW_HERO_WEAPON_REPLACE", slot1, slot0.HeroID_)
	end

	if slot0.storyTime and slot0.viewState_ == "story" then
		slot0.storyTime = nil
	end
end

function slot0.Init(slot0)
	slot0.toggleS_ = {}
	slot0.dataList_ = {}
	slot0.sortedList_ = {}
	slot0.viewState_ = ""
	slot0.mainServant_ = {}
	slot0.tmpServant_ = {}
	slot0.strengthSelectedItem_ = 0
	slot0.replaceSelectedItem_ = 0
	slot0.servantMap_ = {}
	slot0.viewStack_ = {}
	slot0.cost_ = 0

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.selectviewGo_, WeaponServantListItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "page")
	slot0.buttonCon_ = ControllerUtil.GetController(slot0.replacebtnBtn_.transform, "enabled")
	slot0.sortCon_ = ControllerUtil.GetController(slot0.btn_sortBtn_.transform, "order")
	slot0.listCon_ = ControllerUtil.GetController(slot0.leftlistTrs_, "conName")
	slot0.watchCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "watch")
	slot0.headCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
	slot0.avatarBtn_1Con_ = ControllerUtil.GetController(slot0.avatarbtn_1Btn_.transform, "avatarBtn_1")
	slot0.avatarBtn_2Con_ = ControllerUtil.GetController(slot0.avatarbtn_2Btn_.transform, "avatarBtn_2")
	slot0.scaleImage_ = slot0:FindCom("UIScaleImage", "", slot0.roleTrs_)
	slot0.detailView_ = WeaponServantDetailView.New(slot0.detailsGo_)
	slot1 = slot0.detailView_

	slot1:SetDescBtn(true)

	slot1 = slot0.detailView_

	slot1:RegisterWatchFunc(function ()
		uv0:SetUIShow(false)

		uv0.scaleImage_.enabled = true
	end)

	slot0.strPage_ = WeaponServantStrPage.New(slot0.strengthenviewGo_)
end

function slot0.OnSelectRace(slot0, slot1)
	slot0.selectedRace_ = slot1
	slot0.sortedList_ = slot0:UpdateData(slot0.type_, slot1)

	slot0.scrollHelper_:StartScroll(#slot0.sortedList_)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_GOLD and uv0.viewState_ == "strength" then
			uv0.strPage_:RefreshGoldText()
		end
	end)
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.scaleImage_

	slot0:AddToggleListener(slot4, function ()
		uv0:SetUIShow(true)
		uv0.scaleImage_:ResetContent()

		uv0.scaleImage_.enabled = false
	end)

	for slot4 = 1, 4 do
		slot0.toggleS_[slot4] = slot0[uv0[slot4] .. "Tgl_"]

		slot0:AddToggleListener(slot0.toggleS_[slot4], function (slot0)
			slot1 = uv0[uv1]

			if uv2.viewState_ == "onlydetail" or uv2.viewState_ == "onlystory" then
				slot1 = "only" .. uv0[uv1]
			end

			if slot0 then
				uv2:RefreshUI(slot1)

				if uv1 == 1 then
					OperationRecorder.Record("WeaponServantView", "detail")
				elseif uv1 == 2 then
					OperationRecorder.Record("WeaponServantView", "upgrade")
				elseif uv1 == 3 then
					OperationRecorder.Record("WeaponServantView", "story")
				end
			end
		end)
	end

	slot0:AddBtnListener(slot0.avatarbtn_1Btn_, nil, function ()
		uv0.inSleepyPage_ = true

		uv0.avatarBtn_1Con_:SetSelectedState("on")
		uv0.avatarBtn_2Con_:SetSelectedState("off")

		slot0 = nil
		slot1 = ServantTools.GetSleepyServantByServant((uv0.viewState_ ~= "replace" or uv0.sortedList_[uv0.replaceSelectedItem_].id) and uv0.mainServant_.id)

		uv0.detailView_:RefreshToSleepyServant(slot1)
		uv0:RefreshServantImg(slot1)

		if slot1 then
			uv0:RefreshStory(slot1)
		end
	end)
	slot0:AddBtnListener(slot0.avatarbtn_2Btn_, nil, function ()
		uv0.inSleepyPage_ = false

		uv0.avatarBtn_1Con_:SetSelectedState("off")
		uv0.avatarBtn_2Con_:SetSelectedState("on")

		slot0 = nil

		if uv0.viewState_ == "replace" then
			slot0 = uv0.sortedList_[uv0.replaceSelectedItem_].id

			uv0.detailView_:SetWeaponServantData(uv0.sortedList_[uv0.replaceSelectedItem_])
		else
			slot0 = uv0.mainServant_.id

			uv0.detailView_:SetWeaponServantData(uv0.mainServant_)
		end

		uv0:RefreshServantImg(slot0)

		if uv0.mainServant_ and uv0.mainServant_.id then
			uv0:RefreshStory(uv0.mainServant_.id)
		end
	end)
	slot0:AddBtnListener(slot0.replacebtnBtn_, nil, function ()
		if uv0.replaceSelectedItem_ == 0 then
			ShowTips("NO_SERVANT_BE_SELECTED")

			return
		end

		slot0 = uv0.sortedList_[uv0.replaceSelectedItem_].uid

		if uv0.mainServant_ and slot0 == uv0.mainServant_.uid then
			ServantAction.ServantReplace(uv0.HeroID_, 0)

			return
		end

		if uv0.servantMap_[slot0] then
			ShowMessageBox({
				title = "Warning",
				content = string.format(GetTips("SERVANT_IS_USING"), GetI18NText(HeroCfg[uv0.servantMap_[slot0]].name)),
				OkCallback = function ()
					ServantAction.ServantReplace(uv0.HeroID_, uv1)
				end
			})

			return
		end

		ServantAction.ServantReplace(uv0.HeroID_, slot0)
	end)
	slot0:AddBtnListener(slot0.strengthenbtnBtn_, nil, function ()
		for slot3 = 1, 3 do
			uv0.toggleS_[slot3].isOn = false
		end

		slot1 = uv0.sortedList_[uv0.replaceSelectedItem_].uid

		if WeaponServantCfg[uv0.sortedList_[uv0.replaceSelectedItem_].id].type == 3 then
			slot3 = nil

			if uv0.HeroID_ then
				slot3 = HeroTools.GetHeroSpecServant(uv0.HeroID_)
			end

			uv0:Go("/weaponServantMerge", {
				race = WeaponServantCfg[slot0].race,
				servantID = slot3,
				costUid = slot1
			})
		else
			uv0.viewStack_[#uv0.viewStack_ + 1] = {
				name = "replace",
				servant = uv0.mainServant_,
				uid = uv0.sortedList_[uv0.replaceSelectedItem_].uid
			}
			uv0.mainServant_ = uv0.sortedList_[uv0.replaceSelectedItem_]
			uv0.replaceSelectedItem_ = 0

			uv0:RefreshUI("strength")
		end
	end)
	slot0:AddBtnListener(slot0.lockbtnBtn_, nil, function ()
		if uv0.viewState_ == "detail" then
			ServantAction.ServantLock(uv0.mainServant_.uid)
		elseif uv0.viewState_ == "replace" then
			ServantAction.ServantLock(uv0.sortedList_[uv0.replaceSelectedItem_].uid)
		end
	end)
	slot0:AddBtnListener(slot0.btn_sortBtn_, nil, function ()
		slot1 = WeaponServantData:GetSortConfig()[2] == 0 and 1 or 0

		WeaponServantData:SetSortConfig(nil, slot1)
		uv0.sortCon_:SetSelectedIndex(slot1)

		uv0.replaceSelectedItem_ = 1

		uv0:RefreshReplaceScroll()
		uv0:RefreshDetail(uv0.sortedList_[1])
		uv0:RefreshServantIcon(uv0.sortedList_[1].id)
	end)
	slot0:AddToggleListener(slot0.servantdropdownDd_, function (slot0)
		WeaponServantData:SetSortConfig(slot0, nil)

		uv0.replaceSelectedItem_ = 1

		uv0:RefreshReplaceScroll()
		uv0:RefreshDetail(uv0.sortedList_[1])
		uv0:RefreshServantIcon(uv0.sortedList_[1].id)
	end)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		slot0 = nil

		if uv0.HeroID_ then
			slot0 = HeroTools.GetHeroSpecServant(uv0.HeroID_)
		end

		uv0:Go("/weaponServantMerge", {
			race = WeaponServantCfg[uv0.mainServant_.id].race,
			servantID = slot0
		})
	end)
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "equip")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, 10, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.OnServantReplace(slot0, slot1, slot2)
	slot0.mainServant_ = HeroTools.GetHeroServantInfo(slot0.HeroID_)
	slot3, slot4 = slot0.scrollHelper_:GetHeadAndTail()
	slot0.servantMap_ = ServantTools.GetServantMap()

	for slot8 = slot3, slot4 do
		slot9 = slot0.scrollHelper_:GetItemByIndex(slot8)

		if slot0.servantMap_[slot0.sortedList_[slot8].uid] then
			slot9:ShowEquiping(true, slot0.servantMap_[slot10])
		else
			slot9:ShowEquiping(false)
		end
	end

	if slot2.servant_id == 0 then
		ShowTips("SUCCESS_REMOVE_SERVANT")
	else
		ShowTips("SUCCESS_EQUIP_SERVANT")
		slot0:PlayHeroTalk(slot0.HeroID_)
	end

	slot0:RefreshDetail(slot0.sortedList_[slot0.replaceSelectedItem_], true)
end

function slot0.OnServantPromote(slot0, slot1, slot2)
	slot0.mainServant_ = WeaponServantData:GetWeaponServantList()[slot0.mainServant_.uid]

	slot0:RefreshUI("strength")
	slot0:Go("servantBreak", {
		stage = slot0.mainServant_.stage - 1
	})
end

function slot0.OnServantLock(slot0, slot1, slot2)
	if slot0.viewState_ == "replace" then
		slot3 = WeaponServantData:GetWeaponServantList()[slot2.uid]
		slot4, slot5 = slot0.scrollHelper_:GetHeadAndTail()

		if slot4 <= slot0.replaceSelectedItem_ and slot0.replaceSelectedItem_ <= slot5 then
			slot0.scrollHelper_:GetItemByIndex(slot0.replaceSelectedItem_):ShowLock(slot3.locked == 1)
		end
	end
end

function slot0.RefreshServantImg(slot0, slot1)
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot1)
end

function slot0.SetUIShow(slot0, slot1)
	if slot1 then
		slot0:ShowDefaultBar()
		slot0.watchCon_:SetSelectedState("show")
	else
		manager.windowBar:HideBar()
		slot0.watchCon_:SetSelectedState("notShow")
	end
end

function slot0.RefreshServantIcon(slot0, slot1)
	if not slot1 then
		slot0.headCon_:SetSelectedState("false")

		return
	end

	if ServantTools.GetSleepyServantByServant(slot1) then
		slot0.headCon_:SetSelectedState("true")

		if slot0.inSleepyPage_ == true then
			slot0.avatarBtn_1Con_:SetSelectedState("on")
			slot0.avatarBtn_2Con_:SetSelectedState("off")
		else
			slot0.avatarBtn_1Con_:SetSelectedState("off")
			slot0.avatarBtn_2Con_:SetSelectedState("on")
		end

		slot0:RefreshSleepyIcon(slot2, slot1)
	else
		slot0.headCon_:SetSelectedState("false")
	end
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.pageController_:SetSelectedState(slot1)

	slot2 = not slot2

	if table.indexof(uv0, slot1) and slot0.toggleS_[slot3].isOn ~= slot2 then
		slot0.toggleS_[slot3].isOn = slot2
	end

	slot0.viewState_ = slot1

	if slot0.storyTime and slot1 ~= "story" then
		slot0.storyTime = nil
	end

	if slot1 == "strength" then
		slot0.strPage_:RefreshUI(slot0.mainServant_, slot0.params_)

		slot0.inSleepyPage_ = false

		slot0.avatarBtn_1Con_:SetSelectedState("off")
		slot0.avatarBtn_2Con_:SetSelectedState("on")

		slot4 = nil

		if slot0.viewState_ == "replace" then
			slot4 = slot0.sortedList_[slot0.replaceSelectedItem_].id

			slot0.detailView_:SetWeaponServantData(slot0.sortedList_[slot0.replaceSelectedItem_])
		else
			slot4 = slot0.mainServant_.id

			slot0.detailView_:SetWeaponServantData(slot0.mainServant_)
		end

		slot0:RefreshServantImg(slot4)

		if slot0.mainServant_ and slot0.mainServant_.id then
			slot0:RefreshStory(slot0.mainServant_.id)
		end

		slot0:RefreshServantImg(slot0.mainServant_.id)
		slot0:RefreshServantIcon(slot0.mainServant_.id)
	elseif slot1 == "replace" then
		slot0.replaceSelectedItem_ = 1

		slot0:RefreshReplaceScroll()
		slot0:RefreshDetail(slot0.sortedList_[1], true)
		slot0:RefreshDropdown()
		slot0:RefreshServantIcon(slot0.sortedList_[1].id)
	elseif slot1 == "strengthSelect" then
		-- Nothing
	elseif slot1 == "detail" then
		if slot0.inSleepyPage_ == false then
			slot0:RefreshDetail(slot0.mainServant_)
			slot0:RefreshServantIcon(slot0.mainServant_.id)
		else
			slot0.detailView_:RefreshToSleepyServant(ServantTools.GetSleepyServantByServant(slot0.mainServant_.id))
		end
	elseif slot1 == "story" then
		if slot0.inSleepyPage_ == false then
			slot0:RefreshStory(slot0.mainServant_.id)
			slot0:RefreshServantImg(slot0.mainServant_.id)
			slot0:RefreshServantIcon(slot0.mainServant_.id)
		else
			slot4 = ServantTools.GetSleepyServantByServant(slot0.mainServant_.id)

			slot0:RefreshServantImg(slot4)
			slot0:RefreshStory(slot4)
		end

		slot0.storyTime = Time.realtimeSinceStartup
	elseif slot1 == "onlydetail" then
		slot0:RefreshDetail(slot0.mainServant_)

		slot0.toggleS_[1].isOn = true

		slot0:RefreshServantIcon()
	elseif slot1 == "onlystory" then
		slot0:RefreshStory(slot0.mainServant_.id)
		slot0:RefreshServantImg(slot0.mainServant_.id)
		slot0:RefreshServantIcon()
	end
end

function slot0.ShowMergeButton(slot0, slot1)
	SetActive(slot0.mergeBtn_.gameObject, slot1)
end

function slot0.RefreshDropdown(slot0)
	slot1 = WeaponServantData:GetSortConfig()

	slot0.sortCon_:SetSelectedIndex(slot1[2])

	slot0.servantdropdownDd_.value = slot1[1]
end

function slot0.RefreshDetail(slot0, slot1, slot2)
	slot0.detailView_:SetWeaponServantData(slot1, slot2, slot0.HeroID_)

	if not slot0.mainServant_ then
		slot0.buttonCon_:SetSelectedState("equip")
	elseif slot1.uid ~= slot0.mainServant_.uid then
		slot0.buttonCon_:SetSelectedState("replace")
	else
		slot0.buttonCon_:SetSelectedState("unequip")
	end

	if WeaponServantCfg[slot1.id].type == 3 then
		slot0.strengthentextText_.text = GetTips("SERVANT_MERGE")
	else
		slot0.strengthentextText_.text = GetTips("PROMOTE")

		slot0.detailView_:SetLockBtn(true)
	end

	slot0:RefreshServantImg(slot1.id)

	slot0.shortdescText_.text = WeaponServantCfg[slot1.id].desc
end

function slot0.RefreshStar(slot0, slot1)
	for slot5 = 1, 5 do
		SetActive(slot0["star" .. slot5 .. "_"], slot5 <= slot1)
	end
end

function slot0.RefreshLock(slot0, slot1)
	if slot1 then
		SetActive(slot0.openGo_, false)
		SetActive(slot0.closeGo_, true)
	else
		SetActive(slot0.openGo_, true)
		SetActive(slot0.closeGo_, false)
	end
end

function slot0.RefreshReplaceScroll(slot0, slot1)
	slot0.servantMap_ = ServantTools.GetServantMap()
	slot0.type_ = 2
	slot2 = WeaponServantData:GetSortConfig()
	slot0.sortedList_ = slot0:UpdateData(slot0.type_, slot2[1], slot2[2])

	if #slot0.sortedList_ == 0 then
		slot0.listCon_:SetSelectedState("false")
	else
		slot0.listCon_:SetSelectedState("true")
	end

	if slot1 then
		for slot6, slot7 in pairs(slot0.sortedList_) do
			if slot1 == slot7.uid then
				slot0.replaceSelectedItem_ = slot6

				slot0.scrollHelper_:StartScroll(#slot0.sortedList_, slot0.replaceSelectedItem_)

				return
			end
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.sortedList_)
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.viewState_ == "replace" then
		slot0:ReplaceIndexItem(slot1, slot2)
	else
		slot0:StrengthIndexItem(slot1, slot2)
	end
end

function slot0.StrengthIndexItem(slot0, slot1, slot2)
	slot3 = slot0.sortedList_[slot1]

	slot2:SetSelectType("equip")
	slot2:RefreshData({
		isEquip = true,
		id = slot3.id,
		number = slot3.stage,
		index = slot1
	})

	if slot0.strengthSelectedItem_ == slot1 then
		slot2:ShowSelect(1)
	else
		slot2:ShowSelect(0)
	end

	if slot0.servantMap_[slot3.uid] then
		slot2:ShowEquiping(true, slot0.servantMap_[slot3.uid])
	else
		slot2:ShowEquiping(false)
	end

	slot2:ShowLock(false)
	slot2:RegistCallBack(function (slot0)
		slot1, slot2 = uv0.scrollHelper_:GetHeadAndTail()

		if uv0.strengthSelectedItem_ == 0 then
			uv1:ShowSelect(1)
			uv0:SetStrengthSelectedItem(slot0.index)
		elseif uv0.strengthSelectedItem_ == slot0.index then
			uv1:ShowSelect(0)
			uv0:SetStrengthSelectedItem(0)
		else
			if slot1 <= uv0.strengthSelectedItem_ and uv0.strengthSelectedItem_ <= slot2 then
				uv0.scrollHelper_:GetItemByIndex(uv0.strengthSelectedItem_):ShowSelect(0)
			end

			uv1:ShowSelect(1)
			uv0:SetStrengthSelectedItem(slot0.index)
		end
	end)
end

function slot0.ReplaceIndexItem(slot0, slot1, slot2)
	slot3 = slot0.sortedList_[slot1]

	slot2:SetSelectType("common")
	slot2:RefreshData({
		isAdd = false,
		isEquip = true,
		id = slot3.id,
		number = slot3.stage,
		index = slot1
	})

	if slot0.replaceSelectedItem_ == slot1 then
		slot2:ShowSelect(1)
	else
		slot2:ShowSelect(0)
	end

	if slot0.servantMap_[slot3.uid] then
		slot2:ShowEquiping(true, slot0.servantMap_[slot3.uid])
	else
		slot2:ShowEquiping(false)
	end

	if slot3.locked == 1 then
		slot2:ShowLock(true)
	else
		slot2:ShowLock(false)
	end

	slot2:RegistCallBack(function (slot0)
		slot1, slot2 = uv0.scrollHelper_:GetHeadAndTail()

		if uv0.replaceSelectedItem_ == 0 then
			uv1:ShowSelect(1)
			uv0:SetReplaceSelectedItem(slot0.index)
		elseif uv0.replaceSelectedItem_ ~= slot0.index then
			if slot1 <= uv0.replaceSelectedItem_ and uv0.replaceSelectedItem_ <= slot2 then
				uv0.scrollHelper_:GetItemByIndex(uv0.replaceSelectedItem_):ShowSelect(0)
			end

			uv1:ShowSelect(1)
			uv0:SetReplaceSelectedItem(slot0.index)
		end
	end)
end

function slot0.SetReplaceSelectedItem(slot0, slot1)
	slot0.replaceSelectedItem_ = slot1

	if slot1 ~= 0 then
		slot0.inSleepyPage_ = false

		slot0:RefreshDetail(slot0.sortedList_[slot1], true)
		slot0:RefreshServantIcon(slot0.sortedList_[slot1].id)
	end
end

function slot0.RefreshSleepyIcon(slot0, slot1, slot2)
	slot0.headicon1Img_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Icon438x238/" .. slot1)
	slot0.headicon2Img_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Icon438x238/" .. slot2)

	CommonTools.Convert2SamePosition(slot0.avataTrs_, slot0.avataposTrs_)
end

function slot0.RefreshStory(slot0, slot1)
	slot0.storyText_.text = WeaponServantCfg[slot1].story
end

function slot0.UpdateData(slot0, slot1, slot2, slot3)
	slot0.raceList_ = {}
	slot0.raceCount_ = {}
	slot4 = {}

	if slot1 == 1 then
		slot5 = WeaponServantCfg[slot0.mainServant_.id].starlevel

		for slot9, slot10 in pairs(slot0.dataList_) do
			slot11 = slot0.servantMap_[slot10.uid]
			slot12 = slot5 == WeaponServantCfg[slot10.id].starlevel
			slot13 = slot10.uid == slot0.mainServant_.uid
			slot14 = slot10.id == slot0.mainServant_.id
			slot16 = WeaponServantCfg[slot10.id].race

			if (function ()
				if uv0 and uv1.locked ~= 1 and not uv2 and not uv3 and (uv4.selectedRace_ == nil or uv4.selectedRace_ == uv5) and uv6.type ~= 3 and uv7 then
					return true
				end

				return false
			end)() then
				if not table.indexof(slot0.raceList_, slot16) then
					table.insert(slot0.raceList_, slot16)
				end

				if not slot0.raceCount_[slot16] then
					slot0.raceCount_[slot16] = 0
				end

				slot0.raceCount_[slot16] = slot0.raceCount_[slot16] + 1

				table.insert(slot4, slot10)
			end
		end

		slot0.raceCount_[0] = #slot4

		table.sort(slot4, function (slot0, slot1)
			slot2 = WeaponServantCfg[slot0.id].starlevel
			slot3 = WeaponServantCfg[slot1.id].starlevel
			slot6 = WeaponServantCfg[slot0.id].race
			slot7 = WeaponServantCfg[slot1.id].race
			slot8 = slot0.id
			slot9 = slot1.id
			slot10 = slot0.uid
			slot11 = slot1.uid

			if slot0.stage ~= slot1.stage then
				return slot4 < slot5
			end

			if slot2 ~= slot3 then
				return slot2 < slot3
			end

			if slot6 ~= slot7 then
				return slot6 < slot7
			end

			if slot8 ~= slot9 then
				return slot8 < slot9
			end

			return slot10 < slot11
		end)
	elseif slot1 == 2 then
		slot5 = HeroCfg[slot0.HeroID_].race

		for slot9, slot10 in pairs(slot0.dataList_) do
			if WeaponServantCfg[slot10.id].race == slot5 then
				if not table.indexof(slot0.raceList_, WeaponServantCfg[slot10.id].race) then
					table.insert(slot0.raceList_, slot12)
				end

				if not slot0.raceCount_[slot12] then
					slot0.raceCount_[slot12] = 0
				end

				slot0.raceCount_[slot12] = slot0.raceCount_[slot12] + 1

				table.insert(slot4, slot10)
			end
		end

		slot0.raceCount_[0] = #slot4

		function slot6(slot0, slot1)
			if uv0.mainServant_ then
				if uv0.mainServant_.uid == slot0.uid then
					return true
				elseif uv0.mainServant_.uid == slot1.uid then
					return false
				end
			end

			return 1
		end

		function slot7(slot0, slot1)
			slot2 = ServantTools.GetServantSpecHero(slot0.id)
			slot3 = ServantTools.GetServantSpecHero(slot1.id)

			if slot0.id == slot1.id then
				slot4 = WeaponServantCfg[slot0.id].starlevel
				slot5 = WeaponServantCfg[slot1.id].starlevel
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if slot0.stage ~= slot1.stage then
					return slot7 < slot6
				end

				if slot4 ~= slot5 then
					return slot5 < slot4
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			else
				if uv0.HeroID_ then
					if uv0.HeroID_ == slot2 then
						return true
					elseif uv0.HeroID_ == slot3 then
						return false
					end
				end

				slot4 = WeaponServantCfg[slot0.id].starlevel
				slot5 = WeaponServantCfg[slot1.id].starlevel
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if slot0.stage ~= slot1.stage then
					return slot7 < slot6
				end

				if slot4 ~= slot5 then
					return slot5 < slot4
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			end
		end

		function slot8(slot0, slot1)
			slot2 = ServantTools.GetServantSpecHero(slot0.id)
			slot3 = ServantTools.GetServantSpecHero(slot1.id)

			if slot0.id == slot1.id then
				slot6 = slot0.stage
				slot7 = slot1.stage
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
					return slot5 < slot4
				end

				if slot6 ~= slot7 then
					return slot7 < slot6
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			else
				if uv0.HeroID_ then
					if uv0.HeroID_ == slot2 then
						return true
					elseif uv0.HeroID_ == slot3 then
						return false
					end
				end

				slot6 = slot0.stage
				slot7 = slot1.stage
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
					return slot5 < slot4
				end

				if slot6 ~= slot7 then
					return slot7 < slot6
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			end
		end

		table.sort(slot4, function (slot0, slot1)
			if uv0(slot0, slot1) == 1 then
				if uv1 == 0 then
					if uv2 == 0 then
						return uv3(slot0, slot1)
					else
						return uv3(slot1, slot0)
					end
				elseif uv1 == 1 then
					if uv2 == 0 then
						return uv4(slot0, slot1)
					else
						return uv4(slot1, slot0)
					end
				end
			else
				return slot2
			end
		end)
	end

	return slot4
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()

	slot0.scrollHelper_ = nil

	if slot0.detailView_ then
		slot0.detailView_:Dispose()

		slot0.detailView_ = nil
	end

	if slot0.strPage_ then
		slot0.strPage_:Dispose()

		slot0.strPage_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
