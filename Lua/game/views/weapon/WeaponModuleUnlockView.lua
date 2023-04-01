slot0 = class("WeaponModuleUnlockView", ReduxView)
slot1 = "F6302F"

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModuleUnlockUI"
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

	slot0.attributeItems_ = {}
	slot0.conditionItems_ = {}
	slot0.costItems_ = {}

	for slot4 = 1, 3 do
		slot0.costItems_[slot4] = CommonItem.New(slot0["itemGo" .. slot4 .. "_"])

		slot0.costItems_[slot4]:ShowFloor("3")
		slot0.costItems_[slot4]:SetSelectType("equip")
	end

	slot0.taskController_ = ControllerUtil.GetController(slot0.taskTrans_, "mission")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if not HeroData:GetModuleAssignmentIsFinish(uv0.heroID_) then
			ShowTips("WEAPON_MODULE_UNLOCK_TASK_NOT_COMPLETED")

			return
		end

		if uv0.conditionList_ and uv0.conditionList_[1] then
			for slot3, slot4 in pairs(uv0.conditionList_) do
				if not IsConditionAchieved(slot4, {
					heroId = uv0.heroID_
				}) then
					ShowTips("WEAPON_MODULE_UNLOCK_CONDITION_NOT_FINISH")

					return
				end
			end
		end

		slot1 = {}

		for slot5, slot6 in pairs(WeaponModuleCfg[uv0.heroID_].cost[1]) do
			if slot6[1] ~= 2 then
				table.insert(slot1, slot6)
			end
		end

		for slot5, slot6 in pairs(slot1) do
			if MaterialData:GetMaterial(slot6[1]).num < slot6[2] then
				ShowTips("WEAPON_MODULE_UNLOCK_NOT_ENOUGH")

				return
			end
		end

		if not checkGold(uv0.cost_, true) then
			return
		end

		HeroAction.TryToLevelUpModule(uv0.heroID_)
	end)
	slot0:AddBtnListener(slot0.astrolabeinfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = HeroData:GetLockModuleEffectListByType(uv0.heroID_, 3),
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.servantinfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = HeroData:GetLockModuleEffectListByType(uv0.heroID_, 4),
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.taskGotoBtn_, nil, function ()
		JumpTools.JumpToPage(WeaponModuleCfg[uv0.heroID_].source)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")

	slot0.heroID_ = slot0.params_.heroID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = WeaponModuleCfg[slot0.params_.heroID]
	slot0.nameText_.text = slot1.name

	slot0:RefreshDes()

	slot0.taskText_.text = slot1.task_desc

	if HeroData:GetModuleAssignmentIsFinish(slot0.heroID_) then
		slot0.taskController_:SetSelectedState("clear")
	else
		slot0.taskController_:SetSelectedState("notClear")
	end

	slot0.conditionList_ = slot1.condition[1]
	slot0.conditionSourceList_ = slot1.condition_source[1]

	slot0:RefreshCondition()
	slot0:RefreshCost()
end

function slot0.RefreshDes(slot0)
	slot0.effects_ = WeaponModuleCfg[slot0.params_.heroID].skill[1]
	slot1, slot2, slot3, slot4 = HeroTools.GetModuleAllDes(slot0.effects_, slot0.heroID_)

	if slot1 == nil then
		SetActive(slot0.attrGo_, false)
	else
		SetActive(slot0.attrGo_, true)
		slot0:RefreshAttriItems(slot1)
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.attrGo_.transform)
	end

	if slot2 == nil then
		SetActive(slot0.skillGo_, false)
	else
		SetActive(slot0.skillGo_, true)

		slot0.skillText_.text = slot2

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillGo_.transform)
	end

	if slot3 == nil then
		SetActive(slot0.astrolabeGo_, false)
	else
		SetActive(slot0.astrolabeGo_, true)

		slot0.astrolabeText_.text = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.astrolabeGo_.transform)
	end

	if slot4 == nil then
		SetActive(slot0.servantGo_, false)
	else
		SetActive(slot0.servantGo_, true)

		slot0.servantText_.text = slot4

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.RefreshAttriItems(slot0, slot1)
	slot3 = 1

	for slot7, slot8 in pairs(HeroTools.MergeModuleAttribute(slot1)) do
		if slot0.attributeItems_[slot3] == nil then
			slot0.attributeItems_[slot3] = WeaponModuleAttributeItem.New(GameObject.Instantiate(slot0.attriItemGo_, slot0.attriItemTrans_))
		end

		slot0.attributeItems_[slot3]:SetData(slot7, slot8)

		slot3 = slot3 + 1
	end

	for slot7, slot8 in pairs(slot0.attributeItems_) do
		if slot7 < slot3 then
			slot0.attributeItems_[slot7]:SetIsShow(true)
		else
			slot0.attributeItems_[slot7]:SetIsShow(false)
		end
	end
end

function slot0.RefreshCondition(slot0)
	if slot0.conditionList_ and slot0.conditionList_[1] then
		slot4 = true

		SetActive(slot0.conditonParent_.gameObject, slot4)

		for slot4, slot5 in pairs(slot0.conditionList_) do
			if slot0.conditionItems_[slot4] then
				slot0.conditionItems_[slot4]:SetData(slot5, slot0.heroID_, slot0.conditionSourceList_[slot4])
			else
				slot0.conditionItems_[slot4] = WeaponModuleConditionItem.New(GameObject.Instantiate(slot0.conditonGo_, slot0.conditonParent_))

				slot0.conditionItems_[slot4]:SetData(slot5, slot0.heroID_, slot0.conditionSourceList_[slot4])
			end
		end

		slot1 = #slot0.conditionList_

		for slot5, slot6 in pairs(slot0.conditionItems_) do
			if slot1 < slot5 then
				slot6:SetIsShow(false)
			else
				slot6:SetIsShow(true)
			end
		end
	else
		SetActive(slot0.conditonParent_.gameObject, false)
	end
end

function slot0.RefreshCost(slot0)
	slot2 = {}
	slot0.cost_ = 0

	for slot6, slot7 in pairs(WeaponModuleCfg[slot0.heroID_].cost[1]) do
		if slot7[1] == 2 then
			slot0.cost_ = slot7[2]
			slot0.goldNum_.text = slot7[2]
		else
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot8 = slot7[2]
		slot9 = MaterialData
		slot11 = slot0.costItems_[slot6]

		slot11:RefreshData({
			id = slot7[1],
			number = setTextColor(uv0, "C5CCD3", slot9:GetMaterial(slot7[1]).num, slot8, function (slot0, slot1)
				return slot0 < slot1
			end) .. "/" .. slot8
		})

		slot11 = slot0.costItems_[slot6]

		slot11:RegistCallBack(function ()
			ShowPopItem(POP_SOURCE_ITEM, {
				uv0[1],
				uv0[2]
			})
		end)
	end

	for slot6 = 1, 3 do
		if slot6 > #slot2 then
			slot0.costItems_[slot6]:Show(false)
		else
			slot0.costItems_[slot6]:Show(true)
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attributeItems_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.conditionItems_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.costItems_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
