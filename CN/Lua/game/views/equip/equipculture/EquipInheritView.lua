slot0 = class("EquipInheritView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipInheritUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.costController_ = ControllerUtil.GetController(slot0.transform_, "costState")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costItemList_ = LuaList.New(handler(slot0, slot0.IndexCostItem), slot0.uiList_, CommonItem)
	slot0.descText_.text = GetTips("EQUIP_INHERIT_DESC")
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnInherit_, nil, function ()
		if uv0.selectSuitID_ == -1 then
			ShowTips("EQUIP_INHERIT_SELECT")
		elseif uv0.selectSuitID_ == uv0.equipCfg_.suit then
			ShowTips("ERROR_EQUIP_SAME_ID")
		elseif uv0.materialEnough_ == false then
			ShowTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
		elseif uv0.goldEnough_ == false then
			slot0 = false
			slot2 = ipairs
			slot4 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}

			for slot5, slot6 in slot2(slot4) do
				if ItemTools.getItemNum(slot6) > 0 then
					slot0 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot0 then
				JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips(GetTips("ERROR_ITEM_NOT_ENOUGH_GOLD"))
			end
		else
			JumpTools.OpenPageByJump("equipInheritComfirm", {
				equipID = uv0.equipID_,
				suitID = uv0.selectSuitID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.btnAdd_, nil, function ()
		JumpTools.OpenPageByJump("equipInheritPrefabSelect", {
			equipID = uv0.equipID_,
			suitId = uv0.selectSuitID_,
			currentSuitId = uv0.selectSuitID_,
			selectSuitHandler = handler(uv0, uv0.OnSelectSuit)
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipID_ = slot0.params_.equipId
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]

	if slot0.params_.isEnter == true then
		slot0.stateController_:SetSelectedState("false")
		slot0.costController_:SetSelectedState("false")

		slot0.params_.isEnter = nil
		slot0.selectSuitID_ = -1
	elseif slot0.selectSuitID_ ~= nil and slot0.selectSuitID_ ~= -1 then
		slot0:RefreshMoney()
		slot0:RefreshMaterial()
	end

	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipID_ = slot1
	slot0.params_.equipId = slot1
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]
	slot0.selectSuitID_ = -1

	slot0:OnSelectSuit()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RefreshMoney(slot0)
	slot1 = slot0.moneyCost_
	slot3 = tostring(slot1)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1 then
		slot3 = "<color='#FF0000'>" .. slot3 .. "</color>"
	end

	slot0.goldEnough_ = slot1 <= slot2
	slot0.costNum_.text = slot3
end

function slot0.RefreshMaterial(slot0)
	slot0.materialEnough_ = true

	slot0.costItemList_:StartScroll(#slot0.materialList_)
end

function slot0.IndexCostItem(slot0, slot1, slot2)
	slot3 = slot0.materialList_[slot1]

	slot2:RefreshData(slot3)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
	end)

	slot4 = 0

	if ItemCfg[slot3.id].type == ItemConst.ITEM_TYPE.MATERIAL then
		slot4 = MaterialData:GetMaterial(slot3.id) and slot6.num or 0
	elseif slot5 == ItemConst.ITEM_TYPE.CURRENCY then
		slot4 = CurrencyData:GetCurrencyNum(slot3.id)
	end

	slot6 = tostring(slot4)

	if slot4 < slot3.number then
		slot6 = "<color='#FF0000'>" .. slot6 .. "</color>"
	end

	slot2:SetBottomText(slot6 .. "/" .. slot3.number)

	if slot0.materialEnough_ == true then
		slot0.materialEnough_ = slot3.number <= slot4
	end
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshMoney()
	end
end

function slot0.OnSelectEquip(slot0, slot1)
	slot0.selectEquipInfo_ = slot1
	slot0.selectEquipID_ = slot1 and slot1.equip_id or nil

	if slot0.selectEquipInfo_ then
		slot0.selectEquipItem_:RefreshData(slot0.selectEquipInfo_)
		slot0.stateController_:SetSelectedState("true")
	else
		slot0.stateController_:SetSelectedState("false")
	end
end

function slot0.OnSelectSuit(slot0, slot1)
	slot2 = nil

	if slot1 ~= nil then
		slot0.selectSuitID_ = slot1

		SetSpriteWithoutAtlasAsync(slot0.suitImg_, SpritePathCfg.EquipIcon.path .. slot0.selectSuitID_)
		slot0.stateController_:SetSelectedState("true")
		slot0.costController_:SetSelectedState("true")

		slot0.materialList_, slot0.moneyCost_ = EquipData:GetInheritCost(slot0.selectSuitID_)

		slot0:RefreshMaterial()
		slot0:RefreshMoney()
	else
		slot0.stateController_:SetSelectedState("false")
		slot0.costController_:SetSelectedState("false")
	end
end

function slot0.OnEquipInherit(slot0)
	slot0.selectSuitID_ = -1
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]

	slot0.stateController_:SetSelectedState("false")
	slot0.costController_:SetSelectedState("false")
	slot0.params_.inheritHandler()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = {
				"Textures/ChapterPaint/chapter/equip_courses_01",
				"Textures/ChapterPaint/chapter/equip_courses_02",
				"Textures/ChapterPaint/chapter/equip_courses_03",
				"Textures/ChapterPaint/chapter/equip_courses_04",
				"Textures/ChapterPaint/chapter/equip_courses_05",
				"Textures/ChapterPaint/chapter/equip_courses_06",
				"Textures/ChapterPaint/chapter/equip_courses_07",
				"Textures/ChapterPaint/chapter/equip_courses_08"
			}
		}
	})
end

return slot0
