slot0 = class("WeaponView", ReduxView)
slot1 = {
	"detail",
	"strength",
	"promote"
}
slot2 = "CD421E"
slot3 = "363A42"

function slot4(slot0, slot1, slot2)
	slot3 = slot2

	for slot7 = #slot0, 1, -1 do
		slot8 = slot0[slot7]
		slot9 = ItemCfg[slot8.id].param[1]

		if slot3 - math.max(math.min(math.ceil(slot3 / slot9), slot8.number), 0) * slot9 < 0 and slot7 > 1 then
			slot11 = 0

			for slot15 = 1, slot7 - 1 do
				slot11 = slot11 + ItemCfg[slot0[slot15].id].param[1] * slot0[slot15].number
			end

			if slot11 >= slot3 + slot9 and slot10 > 0 then
				slot10 = slot10 - 1
				slot3 = slot3 + slot9
			end
		end

		slot8.select = slot10
	end

	for slot7 = 1, #slot1 do
		if not (ItemCfg[slot1[slot7].id].rare >= 4 or slot8.stage ~= 1) then
			slot11 = GameSetting.base_exp_weapon_servant.value[ItemCfg[slot8.id].rare]

			if slot3 <= 0 then
				slot8.select = 0
			else
				slot8.select = 1
				slot3 = slot3 - slot11
			end
		else
			slot8.select = 0
		end
	end

	return slot2 - slot3
end

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.toggleS_ = {}
	slot0.heroID_ = 0
	slot0.weaponInfo_ = {}
	slot0.canP_ = false
	slot0.strMaterialList_ = {}
	slot0.servantList_ = {}
	slot0.listLen_ = 0
	slot0.totalSelect_ = 0
	slot0.breakItemInit_ = false
	slot0.breakItemS = {}
	slot0.strState_ = ""
	slot0.totalExp_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.rightController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "right")
	slot0.leftController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "left")
	slot4 = "break"
	slot0.breakController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)

	slot0:BindCfgUI()

	for slot4 = 1, 3 do
		slot0.toggleS_[slot4] = slot0[uv0[slot4] .. "Tgl_"]
	end

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollGo_, CommonItem)
	slot0.weaponAvatarView_ = WeaponAvatarView.New(slot0, slot0.displayGo_)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			if uv0.rightController_:GetSelectedState() == "strength" then
				uv0.totalmoneyText_.text = setTextColor(uv1, uv2, uv0.totalExp_ * GameSetting.weapon_strengthen_gold_cost.value[1], CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))

				uv0:RefreshStrInfo(uv0.totalSelect_ ~= 0)
			elseif uv0.rightController_:GetSelectedState() == "promote" then
				slot2, slot3 = WeaponTools.BreakMaterial(uv0.weaponInfo_.breakthrough)
				uv0.costmoneyText_.text = setTextColor(uv1, uv2, slot2, CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))
			end
		end
	end)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0.toggleS_[slot4], function (slot0)
			if slot0 then
				uv0:RefreshUI(uv1[uv2])

				if uv2 == 1 then
					OperationRecorder.Record("hero", "weaponPage1")
				elseif uv2 == 2 then
					OperationRecorder.Record("hero", "weaponPage2")
				elseif uv2 == 3 then
					OperationRecorder.Record("hero", "weaponPage3")
				end
			end
		end)
	end

	slot0:AddBtnListener(slot0.upgradebtnBtn_, nil, function ()
		if uv0.totalSelect_ == 0 then
			ShowTips("PLEASE_SELECT_ITEM")

			return
		end

		slot0, slot1, slot2 = WeaponTools.AddWeaponExp(uv0.weaponInfo_.exp, uv0.weaponInfo_.breakthrough, uv0.totalSelect_)

		if not checkGold((uv0.totalSelect_ - slot2) * GameSetting.weapon_strengthen_gold_cost.value[1], true) then
			return
		end

		slot5 = false
		slot6 = uv0.heroID_
		slot7 = {}

		for slot11, slot12 in pairs(uv0.strMaterialList_) do
			if slot12.select ~= 0 then
				table.insert(slot7, {
					id = slot12.id,
					num = slot12.select
				})
			end
		end

		slot8 = {}

		for slot12, slot13 in pairs(uv0.servantList_) do
			if slot13.select ~= 0 then
				if ItemCfg[slot13.id].rare == 5 then
					slot5 = true
				end

				table.insert(slot8, slot13.uid)
			end
		end

		slot9 = nil

		if #MaterialTools.materialGiveBack(slot2, ItemConst.STR_ITEM.WEAPON) > 0 then
			uv0:Go("materialPreview", {
				content = (not slot5 or string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW_AND_RARE"))) and string.format(GetTips("WEAPON_STRENGTH_EXP_OVERFLOW")),
				OkCallback = function ()
					WeaponAction.WeaponStr(uv0, uv1, uv2)
				end,
				itemList = slot10
			})

			return
		end

		if slot5 then
			ShowMessageBox({
				title = "Warning",
				content = string.format(GetTips("WEAPON_STRENGTH_COST_RARE")),
				OkCallback = function ()
					OperationRecorder.Record("hero", "weaponOKUpgrade")
					WeaponAction.WeaponStr(uv0, uv1, uv2)
				end,
				CancelCallback = function ()
					OperationRecorder.Record("hero", "weaponCancelUpgrade")
				end
			})

			return
		end

		WeaponAction.WeaponStr(slot6, slot7, slot8)
	end)
	slot0:AddBtnListener(slot0.choicebtnBtn_, nil, function ()
		slot5 = uv0.servantList_
		slot6 = WeaponTools.CurMaxExp(uv0.weaponInfo_.breakthrough) - uv0.weaponInfo_.exp
		uv0.totalSelect_ = uv1(uv0.strMaterialList_, slot5, slot6)

		for slot5, slot6 in pairs(uv0.scrollHelper_:GetItemList()) do
			slot6:ShowSelect(slot6.info_.select)
		end

		uv0:RefreshStrInfo(uv0.totalSelect_ ~= 0)
	end)
	slot0:AddBtnListener(slot0.promoteBtn_, nil, function ()
		if WeaponAction.CheckBreak(uv0.heroID_, true) then
			WeaponAction.WeaponBreak(uv0.heroID_)
		end
	end)
end

function slot0.OnWeaponStr(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2.material_list) do
		MaterialAction.MaterialModify(slot7.id, -slot7.num)
	end

	slot3, slot4, slot5 = WeaponTools.AddWeaponExp(slot0.weaponInfo_.exp, slot0.weaponInfo_.breakthrough, slot0.totalSelect_)
	slot6 = slot0.totalSelect_ - slot5
	slot9 = GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1]

	HeroAction.WeaponStr(slot0.heroID_, slot4, slot0.weaponInfo_.exp + slot6)
	CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -slot6 * GameSetting.weapon_strengthen_gold_cost.value[1])

	if slot0.weaponInfo_.level == slot4 then
		ShowTips("SUCCESS_STRENGTHEN")
		slot0:RefreshUI("strength")

		return
	end

	if slot8 == HeroConst.WEAPON_LV_MAX then
		slot0:RefreshUI("detail")
	elseif slot8 == slot9 then
		slot0:RefreshUI("promote")
	else
		slot0:RefreshUI("strength")
	end

	JumpTools.OpenPageByJump("weaponStr", {
		oriLv = slot7,
		afterLv = slot8,
		breakthrough = slot0.weaponInfo_.breakthrough,
		callback = function ()
			getReward(MaterialTools.materialGiveBack(uv0, ItemConst.STR_ITEM.WEAPON))
		end
	})
end

function slot0.OnWeaponBreak(slot0, slot1, slot2)
	slot3, slot4 = WeaponTools.BreakMaterial(slot0.weaponInfo_.breakthrough)

	for slot8, slot9 in ipairs(slot4) do
		MaterialAction.MaterialModify(slot9[1], -slot9[2])
	end

	JumpTools.OpenPageByJump("weaponBreak", {
		heroID = slot0.heroID_,
		breakthrough = slot0.weaponInfo_.breakthrough
	})
	CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -slot3)
	HeroAction.WeaponBreak(slot0.heroID_, slot0.weaponInfo_.breakthrough + 1)
	slot0:RefreshUI("strength")
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("equip")
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

	slot0.switchTogglegroup_.allowSwitchOff = false

	if not slot0.params_ then
		error("应该传入参数")

		return
	end

	slot0.heroID_ = slot0.params_.HeroID
	slot0.weaponInfo_ = HeroData:GetHeroList()[slot0.heroID_].weapon_info

	slot0.weaponAvatarView_:OnEnter(2)
	slot0.weaponAvatarView_:SetWeaponID(HeroTools.HeroUsingSkinInfo(slot0.heroID_).id)
	slot0:RefreshUI(slot0.params_.state)
	slot0:AddEventListeners()
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialUpdate))
end

function slot0.OnMaterialUpdate(slot0)
	if slot0.params_.state == "promote" then
		slot0:RefreshUI(slot0.params_.state)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()

	slot0.switchTogglegroup_.allowSwitchOff = true

	for slot4, slot5 in ipairs(slot0.toggleS_) do
		slot5.isOn = false
	end

	slot0:RemoveAllEventListener()
	slot0.weaponAvatarView_:OnExit()
	OperationRecorder.RecordStayView("STAY_VIEW_HERO_WEAPON", slot0:GetStayTime(), slot0.heroID_)
end

function slot0.RefreshUI(slot0, slot1)
	if GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] == slot0.weaponInfo_.level and slot0.weaponInfo_.level ~= HeroConst.WEAPON_LV_MAX then
		slot0.canP_ = true

		if slot1 == "strength" then
			slot1 = "promote"
		end
	else
		slot0.canP_ = false
	end

	slot0.weaponInfo_ = HeroData:GetHeroList()[slot0.heroID_].weapon_info

	if slot0.weaponInfo_.level == HeroConst.WEAPON_LV_MAX and slot1 ~= "detail" then
		ShowTips("ERROR_USER_MAX_LV")

		slot1 = "detail"
	end

	if table.indexof(uv0, slot1) and not slot0.toggleS_[slot2].isOn then
		slot0.toggleS_[slot2].isOn = true

		return
	end

	slot0.rightController_:SetSelectedState(slot1)

	slot0.params_.state = slot1

	if slot1 == "detail" then
		slot0:RefreshDetail()

		if slot0.canP_ then
			slot0.leftController_:SetSelectedState("promote")
		else
			slot0.leftController_:SetSelectedState("strength")
		end
	elseif slot1 == "strength" then
		slot0.leftController_:SetSelectedState("strength")
		slot0:RefreshStrInfo()
		slot0:RefreshStrScroll()
	elseif slot1 == "promote" then
		slot0.leftController_:SetSelectedState("promote")
		slot0:RefreshBreakInfo()
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	OperationRecorder.Record("hero", "weaponUpgradeSelectMaterial")

	slot3 = 1

	if slot1 > #slot0.strMaterialList_ then
		slot3 = 2
		slot1 = slot1 - #slot0.strMaterialList_
	end

	slot4 = nil

	if slot3 == 1 then
		slot4 = slot0.strMaterialList_[slot1]
	elseif slot3 == 2 then
		slot4 = slot0.servantList_[slot1]
	end

	slot4.index = slot1
	slot4.isEquip = slot4.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT

	slot2:RefreshData(slot4)
	slot2:ShowSelect(slot4.select)

	if slot4.type == ItemConst.ITEM_TYPE.MATERIAL then
		slot2:RegistLongCallBack(function (slot0)
			slot2, slot3, slot4, slot5 = WeaponTools.AddWeaponExp(uv0.weaponInfo_.exp, uv0.weaponInfo_.breakthrough, uv0.totalSelect_)

			if slot5 then
				ShowTips("LEVEL_MAX")

				return false
			end

			if slot0.select < slot0.number then
				slot0.select = slot0.select + 1

				uv1:ShowSelect(slot0.select)

				uv0.totalSelect_ = uv0.totalSelect_ + ItemCfg[slot0.id].param[1]

				uv0:RefreshStrInfo(true)
				manager.audio:PlayUIAudio(2)

				return true
			else
				return false
			end
		end)
	elseif slot4.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot2:RegistCallBack(function (slot0)
			slot3 = GameSetting.base_exp_weapon_servant.value[ItemCfg[slot0.id].rare]
			slot4, slot5, slot6, slot7 = WeaponTools.AddWeaponExp(uv0.weaponInfo_.exp, uv0.weaponInfo_.breakthrough, uv0.totalSelect_)

			if slot0.select == 1 then
				slot0.select = 0

				uv1:ShowSelect(0)

				uv0.totalSelect_ = uv0.totalSelect_ - slot3
			elseif slot0.select == 0 then
				if slot7 then
					ShowTips("LEVEL_MAX")

					return false
				end

				slot0.select = 1

				uv1:ShowSelect(1)

				uv0.totalSelect_ = uv0.totalSelect_ + slot3
			end

			uv0:RefreshStrInfo(true)
		end)
	end

	slot2:RegistCutCallBack(function (slot0)
		if slot0.type == ItemConst.ITEM_TYPE.MATERIAL and slot0.select >= 1 then
			slot0.select = slot0.select - 1

			uv0:ShowSelect(slot0.select)

			uv1.totalSelect_ = uv1.totalSelect_ - ItemCfg[slot0.id].param[1]

			uv1:RefreshStrInfo(true)
			manager.audio:PlayUIAudio(2)

			return true
		end
	end)
end

function slot0.UpdateData(slot0)
	slot0.servantList_ = {}
	slot0.strMaterialList_ = {}
	slot1 = MaterialData:GetMaterialList()
	slot5 = ItemConst.ITEM_TYPE.MATERIAL

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[slot5]) do
		slot8 = ItemCfg[slot6]

		if slot1[slot6] and slot8.sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP and slot7.num > 0 then
			table.insert(slot0.strMaterialList_, {
				index = 0,
				select = 0,
				type = ItemConst.ITEM_TYPE.MATERIAL,
				id = slot6,
				number = slot7.num
			})
		end
	end

	table.sort(slot0.strMaterialList_, function (slot0, slot1)
		return ItemCfg[slot0.id].rare < ItemCfg[slot1.id].rare
	end)

	for slot6, slot7 in ipairs(ServantTools.GetServantLimited(true, true)) do
		table.insert(slot0.servantList_, {
			index = 0,
			select = 0,
			type = ItemConst.ITEM_TYPE.WEAPON_SERVANT,
			uid = slot7.uid,
			id = slot7.id,
			number = slot7.stage,
			stage = slot7.stage
		})
	end

	table.sort(slot0.servantList_, function (slot0, slot1)
		slot4 = slot0.stage
		slot5 = slot1.stage
		slot6 = WeaponServantCfg[slot0.id].race
		slot7 = WeaponServantCfg[slot1.id].race
		slot8 = slot0.id
		slot9 = slot1.id

		if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
			return slot2 < slot3
		end

		if slot4 ~= slot5 then
			return slot4 < slot5
		end

		if slot6 ~= slot7 then
			return slot6 < slot7
		end

		if slot8 ~= slot9 then
			return slot8 < slot8
		end

		return slot0.uid < slot1.uid
	end)

	slot0.listLen_ = #slot0.servantList_ + #slot0.strMaterialList_
end

function slot0.RefreshDetail(slot0)
	slot0.weaponnameText_.text = HeroCfg[slot0.heroID_].weapon_name
	slot0.nowlevelText_.text = slot0.weaponInfo_.level
	slot0.toplevelText_.text = "/" .. GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] or HeroConst.WEAPON_LV_MAX
	slot0.weaponstoryText_.text = HeroCfg[slot1].weapon_desc
	slot0.atknumText_.text = string.format("%d", WeaponTools.WeaponAtk(slot0.weaponInfo_.level, slot0.weaponInfo_.breakthrough))
	slot0.dcrinameText_.text, slot0.crinumText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 1])
end

function slot0.RefreshStrScroll(slot0)
	slot0.totalSelect_ = 0

	slot0:UpdateData()
	slot0.scrollHelper_:StartScroll(slot0.listLen_)
end

function slot0.RefreshStrInfo(slot0, slot1)
	slot2 = slot0.weaponInfo_.breakthrough

	if slot1 and slot0.totalSelect_ ~= 0 then
		slot3, slot4, slot5 = WeaponTools.AddWeaponExp(slot0.weaponInfo_.exp, slot2, slot0.totalSelect_)
		slot6 = GameLevelSetting[slot4].weapon_level_exp
		slot0.totalExp_ = slot0.totalSelect_ - slot5
		slot7 = string.format("%d", WeaponTools.WeaponAtk(slot0.weaponInfo_.level, slot2))
		slot0.originatkText_.text = slot7

		if slot7 ~= string.format("%d", WeaponTools.WeaponAtk(slot4, slot2)) then
			slot0.afteratkText_.text = "<color='#FF7100'>" .. slot8 .. "</color>"
			slot0.atkArrowImg_.color = Color.New(1, 0.4431373, 0, 1)

			SetActive(slot0.atkSelect_, true)
		else
			slot0.afteratkText_.text = slot8
			slot0.atkArrowImg_.color = Color.New(0.2117647, 0.227451, 0.2588235, 1)

			SetActive(slot0.atkSelect_, false)
		end

		if slot0.weaponInfo_.level < slot4 then
			slot0.originbarImg_.fillAmount = 0
		end

		slot0.afterbarImg_.fillAmount = slot3 / slot6
		slot0.afterlvText_.text = slot4
		slot0.exptextText_.text = slot3 .. "/" .. slot6
		slot0.totalexpText_.text = "+" .. slot0.totalExp_

		SetActive(slot0.maxGo_, GameSetting.weapon_exp_limit.value[slot2 + 1] == slot4)
	else
		slot3 = WeaponTools.WeaponAtk(slot0.weaponInfo_.level, slot2)
		slot4, slot5, slot6 = WeaponTools.AddWeaponExp(slot0.weaponInfo_.exp, slot2, 0)
		slot7 = GameLevelSetting[slot5].weapon_level_exp
		slot0.originatkText_.text = string.format("%d", slot3)
		slot0.afteratkText_.text = string.format("%d", slot3)
		slot0.atkArrowImg_.color = Color.New(0.2117647, 0.227451, 0.2588235, 1)

		SetActive(slot0.atkSelect_, false)

		slot0.originbarImg_.fillAmount = slot4 / slot7
		slot0.afterbarImg_.fillAmount = slot4 / slot7
		slot0.afterlvText_.text = slot5
		slot0.exptextText_.text = slot4 .. "/" .. slot7
		slot0.totalexpText_.text = "+0"
		slot0.originlvText_.text = slot5

		SetActive(slot0.maxGo_, false)

		slot0.totalExp_ = 0
	end

	slot0.totalmoneyText_.text = setTextColor(uv0, uv1, slot0.totalExp_ * GameSetting.weapon_strengthen_gold_cost.value[1], CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))
end

function slot0.RefreshBreakInfo(slot0)
	if slot0.weaponInfo_.breakthrough == #GameSetting.weapon_exp_limit.value - 1 then
		print("似乎发生了错误")

		return
	end

	slot4 = slot0.weaponInfo_.level
	slot5 = HeroCfg[slot0.heroID_].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 1][2]
	slot6 = HeroCfg[slot0.heroID_].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 2][2]
	slot0.breaklvText_.text = GameSetting.weapon_exp_limit.value[slot1 + 2]
	slot0.beforebreakatkText_.text = string.format("%d", WeaponTools.WeaponAtk(slot4, slot1))
	slot0.afterbreakatkText_.text = string.format("%d", WeaponTools.WeaponAtk(slot4, slot1 + 1))
	slot9, slot0.beforebreakcriText_.text = SkillTools.GetAttr(HeroCfg[slot0.heroID_].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 1])
	slot11, slot12 = SkillTools.GetAttr(HeroCfg[slot0.heroID_].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 2])
	slot0.pcrinameText_.text = slot11
	slot0.afterbreakcriText_.text = slot12
	slot12 = GameSetting.weapon_user_limit.value[slot1 + 1]
	slot0.requiredescribeText_.text = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot12)

	if PlayerData:GetPlayerInfo().userLevel < slot12 then
		slot0.breakController_:SetSelectedState("no")
	else
		slot0.breakController_:SetSelectedState("can")
	end

	slot0.selectImg_.enabled = slot12 <= PlayerData:GetPlayerInfo().userLevel
	slot14, slot15 = WeaponTools.BreakMaterial(slot1)
	slot0.costmoneyText_.text = setTextColor(uv0, uv1, slot14, CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))

	slot0:RefreshBreakItemS(slot15, slot0.brreakitemGo_, slot0.layoutTrs_)
end

function slot0.RefreshBreakItemS(slot0, slot1, slot2, slot3)
	slot4 = 1

	for slot8 = 1, #slot1 do
		slot4 = slot4 + 1

		if not slot0.breakItemS[slot8] then
			slot0.breakItemS[slot8] = CommonItem.New(Object.Instantiate(slot2, slot3))
			slot10 = slot0.breakItemS[slot8]

			slot10:RegistCallBack(function (slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.realNum
				})
			end)
		end

		slot0.breakItemS[slot8]:Show(true)
		slot0.breakItemS[slot8]:RefreshData({
			id = slot1[slot8][1],
			number = setTextColor(uv0, "33363B", MaterialData:GetMaterial(slot1[slot8][1]).num, slot1[slot8][2], function (slot0, slot1)
				return slot0 < slot1
			end) .. "/" .. slot1[slot8][2],
			realNum = slot1[slot8][2]
		})
	end

	for slot8 = slot4, #slot0.breakItemS do
		slot0.breakItemS[slot8]:Show(false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.breakItemS) do
		slot5:Dispose()
	end

	slot0.weaponAvatarView_:Dispose()

	slot0.weaponAvatarView_ = nil

	slot0.scrollHelper_:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
